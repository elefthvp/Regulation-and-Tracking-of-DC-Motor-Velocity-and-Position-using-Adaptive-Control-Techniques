%%
%Based on Direct Adaptive Tracking - p.213
%%
clear all
close all

%% simulation time definition
interval=0.1;
t_space = 0:interval:50;

%% constant reference definition
syms time
f = 0.25;
w = 2*pi*f;
ymsym = 3*sin(w*time);
ymdotsym = diff(ymsym,time);
ym1 = matlabFunction(ymsym);
ym1dot = matlabFunction(ymdotsym);

ym = ym1(t_space);
ymdot = ym1dot(t_space);
% yc = yc *ones(1,length(t_space));
%% Plant Definition for simulation purposes
km=250;
kT=0.004;
Tm=0.5;
a = + 1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
Gp_ss = ss(Gp);


gamma1=0.3;
gamma2=0.3;
gamma3 = 0.3;

y=zeros;
e=zeros;
u=zeros;
k1 = zeros(length(t_space),1);
k2 = zeros(length(t_space),1);
k3 = zeros(length(t_space),1);
sgnb = sign(b);


%% APPC process
for i=1:(length(ym)-1)
    
    t = t_space(i):interval:t_space(i+1);
    u(i) = -k1(i)*e(i) - k2(i)*ym(i)-k3(i)*ymdot(i);
    
    input=u(i) * ones(1,length(t));
    temp = lsim(Gp_ss,input,t,y(i));
    y(i+1)=temp(end);
    
    e(i+1)=y(i+1)-ym(i+1);
    
    [k1(i+1),k2(i+1),k3(i+1)]= calculate_k(gamma1,gamma2,gamma3,e(i+1),ym(i+1),ymdot(i+1),t,k1(i),k2(i),k3(i),sgnb);
    
end

figure()
plot(t_space,ym);
hold on
plot(t_space,y);
legend('constant','yp')
title('Desired constant output and y plant output')

figure()
plot(t_space,e);

