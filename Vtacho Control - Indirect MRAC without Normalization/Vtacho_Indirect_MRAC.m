%% April 2021 update

clear all
close all
%% Simulation time definition
interval=0.1;
t_space = 0:interval:500;

%% Model Definition
am = 5;
bm = 2;
r = 5*sin(2*pi*t_space);
% r = r *ones(1,length(t_space));
u_r = r;
Wm = tf(bm,[1 am]);
xm = lsim(Wm,u_r,t_space);
%% Plant Definition for simulation purposes
km=250;
kT=0.004;
Tm=0.5;
a = + 1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
Gp_ss = ss(Gp);
b0=0.2;
sign_b = sign(b);

% %% estimation error calculation
% lamda = 2;
% tf_z = tf([1 0],[1 lamda]);
% z_ss = ss(tf_z);
% 
% tf_Lamda_inv = tf(1,[1 lamda]);
% lamda_inv_ss = ss(tf_Lamda_inv);

%% Initialization of loop variables
gamma1=0.8; 
gamma2=0.5;

x=zeros; %x(0) = xm(0) = 0
k=zeros;
l=zeros;
% z=zeros;
% xsl=zeros;
% usl=zeros;

%x(1)=0; 
a_hat(1)= 0;
b_hat(1) = 4; 
e(1)=0;

%% MRAC Process
for i=1:(length(xm)-1)
% i=1;
   t = t_space(i):interval:t_space(i+1);
   
   %control law
   k(i)= (a_hat(i) + am)/b_hat(i);
   l(i)=bm/b_hat(i);
   u(i)= -k(i)*x(i)+l(i)*r(i);
   
   %ouput calculation
   input=u(i) * ones(1,length(t));
   temp = lsim(Gp_ss,input,t,x(i));
   x(i+1)=temp(end);
   
   %adaptive law
   e(i+1)=x(i+1)-xm(i+1);
   [a_hat(i+1), b_hat(i+1)] = calculate_a_b(gamma1,gamma2,e(i+1),x(i+1),u(i),t,a_hat(i),b_hat(i),b0,sign_b);
   
   %estimtion error parameters
%    z(i+1) = simulate_first_order(z_ss,x(i),t,z(i));
%    xsl(i+1) = simulate_first_order(lamda_inv_ss,x(i),t,xsl(i));
%    usl(i+1) = simulate_first_order(lamda_inv_ss,u(i),t,usl(i));
%    theta_phi(i+1) = -a_hat(i)*xsl(i+1) + b_hat(i)*usl(i+1);
%    estimation_error(i+1) = z(i+1) - theta_phi(i+1);
end

%% Display response data, generate figures
save workspace.mat
figures();
% figure()
% plot(t_space,estimation_error)
%estimation error = tracking error


