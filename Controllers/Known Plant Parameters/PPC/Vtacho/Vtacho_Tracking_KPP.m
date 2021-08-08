%%
%Based on Direct Adaptive Tracking - p.213
%%
clear all
close all

%% simulation time definition
interval=0.14; %0.15 looks ok 0.14 is very good 0.138
t_space = 0:interval:5;

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
km=235.68;
kT=0.0037;
Tm=0.564;
a = + 1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
Gp_ss = ss(Gp);

am=7;

y=zeros;
e=zeros;
u=zeros;
k1star=(am-a)/b
k2star = a/b;
k3star = -1/b;
%kstar calculation proof in my notebook


%% APPC process
for i=1:(length(ym)-1)
    
    t = t_space(i):interval:t_space(i+1);
    u(i) = -k1star*e(i) - k2star*ym(i)-k3star*ymdot(i);
    
    input=u(i) * ones(1,length(t));
    temp = lsim(Gp_ss,input,t,y(i));
    y(i+1)=temp(end);
    
    e(i+1)=y(i+1)-ym(i+1);
    
end

figure(1)
plot(t_space,ym);
hold on
plot(t_space,y);
legend('ym','yp')
title('Desired constant output and y plant output')

figure(2)
plot(t_space,e);

error = abs(e)
figure(3)
plot(t_space,error)
title('Absolute Error')

