
%% August 2021
%%
clear all
close all

%% simulation time definition
interval=0.1;
%2755
t_space = 0:interval:10;

%% Model Definition
am = 1;
bm = 2.5;
r = 2.5;
r = r *ones(1,length(t_space));
% r = sin(t_space);
u_r = r;
Wm = tf(bm,[1 am]);
xm = lsim(Wm,u_r,t_space);
figure()
plot(t_space,xm);
title('desired trajectory');

gamma1=0.3; %0.2 and 0.3 also work
gamma2=0.3;

J=0.00000275;
R=1  %5.35;
Co=18;   %co=3, cs = 5 akoma xeirotero 
Cs=0.2;

%% Plant Definition for simulation purposes
kmu=0.0278;
km=235.68;
kT=0.0037;
Tm=0.564;
a =  1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
Gp_ss = ss(Gp); %for b,a <0 the system is unstable that's why I don't expect k, l to actually converge
% a must be positive, b can be whatever
% test = lsim(Gp_ss,ones(1,length(t_space)),t_space);
% plot(t_space,test)

%% Initialization of loop variables
x=zeros;
u = zeros;
k=zeros;
l=zeros;
k_l = zeros(length(t_space),2);
x(1)=0;
e(1)=0;
kstar=(am-a)/b
lstar=bm/b
% kp = calculate_k(Gp);
% km = calculate_k(Wm);
% sgn = sign(kp)/sign(km); 

%% MRAC process
for i=1:(length(xm)-1)
    
    t = t_space(i):0.1:t_space(i+1);
    u(i) = kstar*x(i) + lstar*r(i); %deleted the minus in front of k_l( , 1) here and put it 
    %in the adaptive law 
  
% if(i>3)
% (a,b,u,t,y_prev,R,Cs,kT)
    temp = integrate_first_order(a,b,u(i),t,x(i),R,Cs,kT)
    x(i+1)=temp(end);
% else
%     input=u(i) * ones(1,length(t));
%     temp = lsim(Gp_ss,input,t,x(i));
%     x(i+1)=temp(end);
% end
    
    e(i+1)=x(i+1)-xm(i+1);
    
%     [k_l(i+1,1),k_l(i+1,2)]= calculate_k_l(gamma1,gamma2,e(i+1),x(i+1),r(i+1),t,k_l(i,:),sign(b)); %sign(b)
    
end

%% Figure Generation
save workspace.mat
figures()
