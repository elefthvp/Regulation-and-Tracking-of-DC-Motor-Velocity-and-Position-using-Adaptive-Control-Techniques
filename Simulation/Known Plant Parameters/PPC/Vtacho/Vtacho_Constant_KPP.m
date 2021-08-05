%%
%Based on Scalar Example: Adaptive Tracking p212. Only applies on a
%constant desired reference.
%%
clear all
close all

%% simulation time definition
interval=0.136; % gia 0.13 kataligei se arketa megalyteri timi, gia katw 0.13 paei se astatheia, gia 0.14 kai anw paei se xamiloteri timi kok
t_space = 0:interval:5;

%% constant reference definition
c = 4;
yc = c *ones(1,length(t_space));
%% Plant Definition for simulation purposes
km=235.68;
kT=0.0037;
Tm=0.564;
a = + 1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
step(Gp)
Gp_ss = ss(Gp);
rlocus(Gp)

%%

y=zeros;
e=zeros;
u=zeros;
am = 10; %the system itself has its pole at -2, I want to make it faster
k1star = (-a+am)/b
k2star = a*c/b

%% APPC process
for i=1:(length(yc)-1)
    
    t = t_space(i):interval:t_space(i+1);
    u(i) = -k1star*e(i) - k2star;
    
    input=u(i) * ones(1,length(t));
    temp = lsim(Gp_ss,input,t,y(i));
    y(i+1)=temp(end);
    
    e(i+1)=y(i+1)-yc(i+1);
    
end

figure()
plot(t_space,yc);
hold on
plot(t_space,y);
legend('constant','yp')
title('Desired constant output and y plant output')

figure()
plot(t_space,e);

datap = stepinfo(y,t_space);
