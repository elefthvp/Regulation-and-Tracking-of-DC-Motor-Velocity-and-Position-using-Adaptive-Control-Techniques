clear all;
close all;

%% Wm definition, Lamda coefficients definition and matching equations solution to generate functions
n = 2;
numerator = 1;
denominator = [2 6 4];
Wm = tf(numerator,denominator);

%Define Lamda Polynomial Parameters
lamda0 = 3;
lamda1 = +2;
kp_max = -0.1;
%@control law: generate functions that calculate theta1, theta2, theta3

k_m = calculate_k(Wm);



%% Time, Reference Input and Reference Model simulation
% r = 5;
% u_r =r*ones(1,length(t_space));

t_space = 0:0.1:200;
r = sin(t_space);
u_1=1*ones(1,length(t_space));

u_r = r;
ym= lsim(Wm,u_r,t_space);

%% Plant Model definition for simulation purposes 
kM=250;
k0=0.2;
kmu=1/30;
Tm=0.5;
a=-k0*kmu*kM;
numerator = a;
denominator = [Tm,1,0];
Gpknown= tf(numerator,denominator);

[k_p,a1star] = calculate_k(Gpknown);

%generate the matching equations that calculate theta vector for every time
%instant during the adaptive loop process 
matching_equations(Wm,n,k_m,k_p);

%% Matrix Initializations

% Adaptive law parameters 
theta_p = zeros(length(t_space),2);
kphat = zeros;
kphat(1) = -0.11;
a1_hat = zeros;
phi = zeros(2,length(t_space));
ms_squared = zeros;
epsilon = zeros;
theta_p(1,:) = [kphat(1) 0];

% Control law parameters
theta=zeros(length(t_space),4);
w=zeros(4,length(t_space));
theta1=zeros;
theta2=zeros;
theta3=zeros;
c0=zeros;
c0(1) = k_m/kphat(1);
theta=[0 0 0 c0(1)];
w = [0 0 0 r(1)]';

% helpful transfer function definitions and the respective state-space
% transformations
% 1/Lamda
Lamda_inv_tf = tf(1, [1 lamda1 lamda0]);
Lamda_inv_ss = ss(Lamda_inv_tf);
w1_ic = zeros(length(t_space),2);
w2_ic = zeros(length(t_space),2);
w1 = zeros(length(t_space),1);
w2 = zeros(length(t_space),1);

%phi2
phi2_ss = generate_phi2ss(lamda0,lamda1); 
phi_1_ic = zeros(length(t_space),2);
phi_2_ic = zeros(length(t_space),2);

phi_1 = zeros(length(t_space));
phi_2 = zeros(length(t_space));

%z = s^2/Lamda
zss = generate_zss(lamda0,lamda1);
z1z2 = zeros(length(t_space),2);

up=zeros;
y=zeros(length(t_space),2);
yp=zeros;

gamma = 0.3;
Gamma = gamma*eye(length(theta_p(1,:)));

syms s
%Theta Star Calculation using the auto-generated calculate theta functions and the actual k_p, a1 of the plant
theta1star = calculate_theta1(a1star,lamda1); 
theta2star  = calculate_theta2(a1star,k_p,lamda0,lamda1);
theta3star  = calculate_theta3(a1star,k_p,lamda0,lamda1);
c0star = k_m/k_p;

%% MRAC process
for i=1:(length(t_space)-1)
    %controller calculation - adaptive law & control law combination
    t = t_space(i):0.1:t_space(i+1);
    u_1=ones(1,length(t));
    
    %controller output calculation
    up(i)= theta(i,:)*w(:,i);
    
    %update yp
    temp1 = update_yp(up(i),t,y(i,:),Tm,a);
    temp2 = temp1.y';
    y(i+1,:) = temp2(end,:);
    yp(i+1)= y(i+1,1); 
    
    %adaptive law
    %z
    [z(i+1),z1z2(i+1,:)] = integrate_secondorder(zss, yp(i+1)*u_1, t,z1z2(i,:));
    
    %phi
    [phi_1(i+1) , phi_1_ic(i+1,:)] = integrate_secondorder(Lamda_inv_ss, up(i)*u_1, t,phi_1_ic(i,:));
    [phi_2(i+1) , phi_2_ic(i+1,:)] = integrate_secondorder(phi2_ss , yp(i+1)*u_1, t,phi_2_ic(i,:));
    phi(:,i+1) = [ phi_1(i+1) ; phi_2(i+1)];
    
    ms_squared(i+1) = 1+ phi(:,i+1)' * phi(:,i+1);
    
    epsilon(i+1) = (z(i+1) - theta_p(i,:) * phi (:,i+1))/ms_squared(i+1);
    
    % theta_p = [kp_hat a1_hat]
    theta_p(i+1,:) = update_theta_p(t,Gamma,epsilon(i+1),phi(:,i+1),kp_max,theta_p(i,:));
    kphat(i+1) = theta_p(i+1,1);
    a1_hat(i+1) = theta_p(i+1,2);
    
    %control law
    theta1(i+1) = calculate_theta1(-a1_hat(i+1),lamda1);
    theta2(i+1) = calculate_theta2(-a1_hat(i+1),kphat(i+1),lamda0,lamda1);
    theta3(i+1) = calculate_theta3(-a1_hat(i+1),kphat(i+1),lamda0,lamda1);
    c0(i+1) = k_m/kphat(i+1);
    
    theta(i+1,:) = [ theta1(i+1) theta2(i+1) theta3(i+1) c0(i+1)];
    
    [w1(i+1,1) , w1_ic(i+1,:)] = integrate_secondorder(Lamda_inv_ss, up(i)*u_1, t,w1_ic(i,:));
    [w2(i+1,1) , w2_ic(i+1,:)] = integrate_secondorder(Lamda_inv_ss, yp(i+1)*u_1, t,w2_ic(i,:));
    w(:,i+1)= [w1(i+1,1) ; w2(i+1,1) ; yp(i+1); r(i+1)];
end

%% Figure Generation
save workspace.mat
figures()

