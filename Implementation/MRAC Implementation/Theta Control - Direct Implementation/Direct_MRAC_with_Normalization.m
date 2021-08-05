
close all;

clearvars -except ard vref_arduino V7805;

arduino_connected=exist('ard');
if(~arduino_connected)
    ard=arduino('COM3');
end

vref_set = exist('vref_arduino');
if(~vref_set)
    [vref_arduino,V7805] = setVref_V7805(ard);
end
motorPowerOff(ard)
%% TO DO
%change t_space to a bigger interval if needed, if adaptation too slow
%a_s calculation is a generalized function but F and g calculation is a
%hard-wired, manually set part.
%better initial conditions for rho, w, theta vector?
%% Order and simulation time definition
n=2;
interval = 0.001;
t_space=0:interval:10;
%% Model Definition
r = 5;
% r=sin(t_space)+sin(0.2*t_space);
u_1=1*ones(1,length(t_space));
% u_r =r*ones(1,length(t_space));
r=r*ones(1,length(t_space));
u_r = r;
numerator = +1;
denominator = [2,6,4];
W_model = tf(numerator,denominator);
% load Improved.mat
% W_model = Hc;
Wm = lsim(W_model,u_1,t_space);
ym= lsim(W_model,u_r,t_space);
figure()
plot(t_space,ym)

%% Plant Definition for simulation purposes
kM=235.68;
k0=0.2347;
kmu=0.0278;
Tm=0.564;
a=k0*kmu*kM;
numerator = a;
denominator = [Tm,1,0];
Gpknown= tf(numerator,denominator);
yact=lsim(Gpknown,u_r,t_space);
plot(t_space,yact);


%% a_s calculation for theoretical analysis purposes
%might be incorporated in a function that covers a generalized case in the
%future
%we are working for n=2 but this code also covers the general case
syms s;
a_s=zeros;
if (n>2)
    for i=2:n
        a_s=[s^(i-2); a_s];
    end
    a_s=a_s(1:end-1);
else
    a_s= s^(n-2);
end

%% Sgn(kp/km) calculation
kp = calculate_k(Gpknown);
km = calculate_k(W_model);
sign1=sign(kp);
sign2=sign(km);
sgn=sign1/sign2;

%% Initialization of loop variables
uint=zeros;
uwritten=zeros;
up=zeros;
yp=zeros;
absolute_displacement(ard,180)
yp(1)=getTheta(ard,vref_arduino)


lamda0=2;
F=-lamda0;
g=1;

theta=zeros(length(t_space),4);
w=zeros(4,length(t_space));

uf=zeros;
e1=zeros;
xi=zeros;
y=zeros(length(t_space),2);
epsilon=zeros;
ms_squared=zeros;
w1w2=zeros(length(t_space),2);
rho=zeros;

gamma = 7;
Gamma = gamma*eye(4);


[theta1star,theta2star, theta3star] = mapping(W_model,Gpknown,n,s+lamda0,km,kp); 
c0star = km/kp;
%% Initial Conditions
rho(1)=3;
w = [0 0 0 r(1)]';
theta=[0 0 0 1/rho(1)];
M0 = [2 2 2 2];
q0 = [1 1 1 1];
sigma0 = [1 1 1 1];
M0_w = [1.5 1.5];


%% MRAC process
for i=1:(length(t_space)-1)
%     i=1;
    t = t_space(i):interval:t_space(i+1);
    %controller calculation
    up(i)= theta(i,:)*w(:,i);
    
    %ouput calculation
    [uint(i), uwritten(i)]=writeU(ard,vref_arduino,up(i));
    disp(up(i))
    disp(uwritten(i))
    yp(i+1)= getTheta(ard,vref_arduino);
    
    
    %helpful law signals calculation
    uf(i+1)=Wm(i+1)*up(i); %change this to Wm(i) ?
    phi(:,i+1)=-Wm(i+1)*w(:,i); %this too
    xi(i+1)= theta(i,:)* phi(:,i+1) + uf(i+1);
    ms_squared(i+1)=1+ phi(:,i+1)'* phi(:,i+1) + uf(i+1)^2;
    e1(i+1)= yp(i+1)-ym(i+1);
    epsilon(i+1)=(e1(i+1)-rho(i)*xi(i+1))/ms_squared(i+1);
    
    
    %theta, w and rho calculation
    theta(i+1,:)= solvethetadot(Gamma,epsilon(i+1),phi(:,i+1),theta(i,:),sgn,t,M0,q0,sigma0);
    temp1= findw1w2(F,g,w1w2(i,:),up(i),yp(i+1),t,M0_w); %,M0_w,q0,sigma0
    w1w2(i+1,:)= [temp1(1).y(end) temp1(2).y(end)];
    w(:,i+1)= [w1w2(i+1,:)' ; yp(i) ; r(i+1)];
    temp1 = update_rho(t,gamma,epsilon(i+1),xi(i+1),rho(i));
    temp2=temp1.y;
    rho(i+1) = temp2(end);
    
end
motorPowerOff(ard)
%% Display response data, generate figures
datam = stepinfo(ym,t_space)
datap = stepinfo(yp,t_space)

% save workspace.mat
% figures()

