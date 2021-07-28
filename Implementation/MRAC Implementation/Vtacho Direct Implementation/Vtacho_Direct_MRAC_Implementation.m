
%% July 2021
%%
clearvars -except ard vref_arduino V7805;

close all

arduino_connected=exist('ard');
if(~arduino_connected)
    ard=arduino('COM3');
end

vref_set = exist('vref_arduino');
if(~vref_set)
    [vref_arduino,V7805] = setVref_V7805(ard);
end



    
%% simulation time definition
interval=0.001;
t_space = 0:interval:5;

%% Model Definition
am = 1;
bm = +2;
r = 4;
r = r *ones(1,length(t_space));
%a reference signal of  5V would result in a steady state velocity of
%37.5375 rpm
% r = 4*sin(0.005*t_space);
% r= 2+sin(1.5*t_space);
u_r = r;
Wm = tf(bm,[1 am]);
xm = lsim(Wm,u_r,t_space);
figure()
plot(t_space,xm);
title('desired trajectory');

gamma1=0.3; %0.2 and 0.3 also work
gamma2=0.3;


%% Plant Definition for simulation purposes -DO NOT NEED THEM, RUN IN ACTUAL PLANT
km=235.68;
kT=0.0037;
Tm=0.564;
a =  1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
% Gp_ss = ss(Gp); %for b,a <0 the system is unstable that's why I don't expect k, l to actually converge
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
uint=zeros;
uwritten=zeros;
%% ADD KP of plant as identified 
kp = calculate_k(Gp);
km = calculate_k(Wm);
sgn = sign(kp)/sign(km); 

%% MRAC process
tic;
for i=1:(length(xm)-1)
    %maybe adjust time kai isws na prosthesw kai mia mikri kathisterisi sto
    %systima giati mporei na min prolavainei na graftei/fanei i allagi
    t = t_space(i):interval:t_space(i+1);
    u(i) = -k_l(i,1)*x(i) + k_l(i,2)*r(i); %deleted the minus in front of k_l( , 1) here and put it 
    %in the adaptive law 
    
    [uint(i) uwritten(i)]=writeU(ard,vref_arduino,u(i));
    
    %isws edw endiamesa na xreiazetai ena mikro pause gia na dw tin diafora
    %meta tin grafi tis timis
    x(i+1)=getVtacho(ard,vref_arduino,V7805);
    
    e(i+1)=x(i+1)-xm(i+1);
    
    [k_l(i+1,1),k_l(i+1,2)]= calculate_k_l(gamma1,gamma2,e(i+1),x(i+1),r(i+1),t,k_l(i,:),sign(b),[1 1.5],[1 1],[2 2]); %sign(b)
    
end
toc;
%implement a stop motor function
motorPowerOff(ard)
%% Figure Generation
% save workspace.mat
% figures()
