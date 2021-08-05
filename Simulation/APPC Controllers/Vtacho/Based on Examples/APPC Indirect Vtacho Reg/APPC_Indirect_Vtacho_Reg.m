%%
%Based on Indirect Adaptive Tracking - p.213-214
%%
clear all
close all
%% for am = 2 and c=2 it has a similar response to the controller implemented using the general theoretical analysis
%%
%I tested this using a sinusoid yc and it kind of works, but the error is >
%0.1 and there is a periodic overshoot phenomenon in "steady state"
%% simulation time definition
interval=0.1;
t_space = 0:interval:100;

%% constant reference definition
am = 2; %the bigger the value of am, the longer the settling time of yp
c = 2; %constant reference
yc = c *ones(1,length(t_space));
% yc=sin(t_space);
%% Plant Definition for simulation purposes
km=250;
kT=0.004;
Tm=0.5;
a = + 1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
Gp_ss = ss(Gp);

k1star = (a+am)/b;
k2star = (a*c)/b;

gamma1=0.3;
gamma2=0.3;

y=zeros;
e=zeros;
u=zeros;
k1 = zeros(length(t_space),1);
k2 = zeros(length(t_space),1);
ahat = zeros(length(t_space),1);
bhat = zeros(length(t_space),1);
b0 = 0.2;
bhat(1) = 0.3;
sgnb = sign(b);

%% APPC process
for i=1:(length(yc)-1)
    
    t = t_space(i):interval:t_space(i+1);
    k1(i) = (ahat(i)+am)/bhat(i);
    k2(i) = (ahat(i)*yc(i))/bhat(i);
    u(i) = -k1(i)*e(i) - k2(i);
    
    input=u(i) * ones(1,length(t));
    temp = lsim(Gp_ss,input,t,y(i));
    y(i+1)=temp(end);
    
    e(i+1)=y(i+1)-yc(i+1);
    
    [ahat(i+1), bhat(i+1)] = calculate_a_b(gamma1,gamma2,e(i+1),y(i+1),u(i),t,ahat(i),bhat(i),b0,sgnb);
    
end

figure()
plot(t_space,yc);
hold on
plot(t_space,y);
legend('constant','yp')
title('Desired constant output and y plant output')

figure()
plot(t_space,e);

stepinfo(y,t_space)
