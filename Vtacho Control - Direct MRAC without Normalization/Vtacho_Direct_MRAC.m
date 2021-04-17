
%% April 2021 update
%%
clear all
close all

%% simulation time definition
interval=0.1;
t_space = 0:interval:30;

%% Model Definition
am = 5;
bm = 2;
r = 5;
r = r *ones(1,length(t_space));
u_r = r;
Wm = tf(bm,[1 am]);
xm = lsim(Wm,u_r,t_space);
figure()
plot(t_space,xm);
title('desired trajectory');

gamma1=0.3; %0.2 and 0.3 also work
gamma2=0.3;


%% Plant Definition for simulation purposes
km=250;
kT=0.004;
Tm=0.5;
a = + 1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
Gp_ss = ss(Gp);

%% Initialization of loop variables
x=zeros;
u = zeros;
k=zeros;
l=zeros;
k_l = zeros(length(t_space),2);
x(1)=0;
e(1)=0;
kstar=(am+a)/b
lstar=bm/b

%% MRAC process
for i=1:(length(xm)-1)
    
    t = t_space(i):interval:t_space(i+1);
    u(i) = -k_l(i,1)*x(i) + k_l(i,2)*r(i);
    
    input=u(i) * ones(1,length(t));
    temp = lsim(Gp_ss,input,t,x(i));
    x(i+1)=temp(end);
    
    e(i+1)=x(i+1)-xm(i+1);
    
    [k_l(i+1,1),k_l(i+1,2)]= calculate_k_l(gamma1,gamma2,e(i+1),x(i+1),r(i+1),t,k_l(i,:),sign(b));
    
end

%% Figure Generation
save workspace.mat
figures()
