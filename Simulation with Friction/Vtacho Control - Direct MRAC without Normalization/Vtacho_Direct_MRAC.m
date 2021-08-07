
%% April 2021 update
%%
clear all
close all

%% simulation time definition
interval=0.1;
t_space = 0:interval:100;

%% Model Definition
am = 1;
bm = +2;
% r = 5;
% r = r *ones(1,length(t_space));
r = 3*sin(t_space);
u_r = r;
Wm = tf(bm,[1 am]);
xm = lsim(Wm,u_r,t_space);
figure()
plot(t_space,xm);
title('desired trajectory');

gamma1=0.7; %0.2 and 0.3 also work
gamma2=0.7;


%% Plant Definition for simulation purposes
km=250;
kT=0.004;
Tm=0.5;
a =  1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
Gp_ss = ss(Gp); %for b,a <0 the system is unstable that's why I don't expect k, l to actually converge
% a must be positive, b can be whatever
% test = lsim(Gp_ss,ones(1,length(t_space)),t_space);
% plot(t_space,test)
R=10; %R=3 and Cs = 20 it works 
Cs=40;
Co=20

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
kp = calculate_k(Gp);
km = calculate_k(Wm);
sgn = sign(kp)/sign(km); 
s_torque=zeros;
Tmotor=zeros;
%% MRAC process
for i=1:(length(xm)-1)
    
    t = t_space(i):interval:t_space(i+1);
    u(i) = -k_l(i,1)*x(i) + k_l(i,2)*r(i); %deleted the minus in front of k_l( , 1) here and put it 
    %in the adaptive law 
    
%     input=u(i) * ones(1,length(t));
%     temp = lsim(Gp_ss,input,t,x(i));
%     x(i+1)=temp(end);
    [x(i+1) s_torque(i+1) Tmotor(i+1)] = integrate_first_order(a,b,u(i),t,x(i),R,Cs,kT)
%      = temp(end);
    e(i+1)=x(i+1)-xm(i+1);
    
    [k_l(i+1,1),k_l(i+1,2)]= calculate_k_l(gamma1,gamma2,e(i+1),x(i+1),r(i+1),t,k_l(i,:),sign(b),[10 10],[1 1],[1 1]); %sign(b)
    
end

%% Figure Generation
save workspace.mat
figures()
