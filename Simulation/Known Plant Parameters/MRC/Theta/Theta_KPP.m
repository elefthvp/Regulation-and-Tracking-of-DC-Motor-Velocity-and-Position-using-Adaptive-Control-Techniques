%%
clear all;
close all;
%% Order and simulation time definition
n=2;
interval = 0.01;
t_space=[0:interval:7];
%% Reference Definition
% r = 2;
r=sin(t_space)
u_1=1*ones(1,length(t_space));
% r=r*ones(1,length(t_space));
u_r = r;
%% Model Definition
numerator = 1;
denominator = [2,6,4];
W_model = tf(numerator,denominator);
% load Improved.mat
% W_model = Hc;
Wm = lsim(W_model,u_1,t_space);
ym= lsim(W_model,u_r,t_space);
plot(t_space,ym)
%% Plant Definition for simulation purposes
kM=235.68;
k0=0.2347;
kmu=1/36;
Tm=0.564;
a=-k0*kmu*kM;
numerator = a;
denominator = [Tm,1,0];
Gpknown= tf(numerator,denominator);
%% Sgn(kp/km) calculation
kp = calculate_k(Gpknown);
km = calculate_k(W_model);
sign1=sign(kp);
sign2=sign(km);
sgn=sign1/sign2;
%% Initialization of loop variables
up=zeros;
y=zeros(length(t_space),2);
yp=zeros;

lamda0=2;
F=-lamda0;
g=1;

w=zeros(4,length(t_space));

y=zeros(length(t_space),2);

w1w2=zeros(length(t_space),2);
%% Theta Calculation 
syms s;
[theta1star,theta2star, theta3star] = mapping(W_model,Gpknown,n,s+lamda0,km,kp); 
c0star = km/kp;
theta = [theta1star,theta2star,theta3star,c0star];
%% Control Law Initial Conditions
w = [0 0 0 r(1)]';
%% MRAC process
for i=1:(length(t_space)-1)
    t = t_space(i):interval:t_space(i+1);
    %controller calculation
    up(i)= theta*w(:,i);
    
    %ouput calculation
    temp1 = update_yp(up(i),t,y(i,:),Tm,a);
    temp2 = temp1.y';
    y(i+1,:) = temp2(end,:);
    yp(i+1)= y(i+1,1);
    
    e1(i+1)= yp(i+1)-ym(i+1);
    
    temp1= findw1w2(F,g,w1w2(i,:),up(i),yp(i+1),t);
    w1w2(i+1,:)= [temp1(1).y(end) temp1(2).y(end)];
    w(:,i+1)= [w1w2(i+1,:)' ; yp(i) ; r(i+1)];
end

%% Display response data, generate figures
datam = stepinfo(ym,t_space);
datap = stepinfo(yp,t_space);
% 
save workspace.mat
figures()

