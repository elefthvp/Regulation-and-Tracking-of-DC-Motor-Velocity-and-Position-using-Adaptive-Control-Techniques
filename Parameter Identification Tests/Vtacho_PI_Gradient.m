% close all
clear all
%% Simulation time definition
interval=0.1;
t_space = 0:interval:150;

r=sin(3*t_space)

%gia lamda panw apo 2 paei stin astatheia
%% Plant definition
km=250;
kT=0.004;
Tm=0.5;
a = + 1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
Gp_ss = ss(Gp);
% b0=0.2;
% sign_b = sign(b)

gamma1=0.3; 
gamma2=0.3;

lamda = 2;
tf_z = tf([1 0],[1 lamda]);
z_ss = ss(tf_z);

tf_Lamda_inv = tf(1,[1 lamda]);
lamda_inv_ss = ss(tf_Lamda_inv);

tf_Lamda_inv = tf(-1,[1 lamda]);
lamda_inv_ss2 = ss(tf_Lamda_inv);

z=zeros;
yp = zeros;

xsl=zeros;
usl=zeros;
est_error=zeros;
a_hat=zeros;
b_hat=zeros;
%+[-xsl(i+1) usl(i+1)]*[-xsl(i+1) usl(i+1)]'
ms_squared = 1
r(1)=r(2)
a_hat(1)=0.1
b_hat(1)=0.1
yap = zeros;
yap(1)=r(1)
yp(1) = r(2)

for i=1:(length(t_space)-1)
% i=1;
    t = t_space(i):interval:t_space(i+1);
    u_1 = ones(1,length(t));
    %adaptive law
   %estimtion error parameters
    z(i+1) = simulate_first_order(z_ss,yap(i)*u_1,t,z(i));
    xsl(i+1) = simulate_first_order(lamda_inv_ss2,yap(i)*u_1,t,xsl(i));
    usl(i+1) = simulate_first_order(lamda_inv_ss,r(i)*u_1,t,usl(i));
    theta_phi(i+1) = +a_hat(i)*xsl(i+1) + b_hat(i)*usl(i+1);
    ms_squared = 1;
    est_error(i+1) = (z(i+1) - theta_phi(i+1))/ms_squared;
    
    [a_hat(i+1), b_hat(i+1)] = calculate_a_b(gamma1,gamma2,est_error(i+1),xsl(i+1),usl(i+1),t,a_hat(i),b_hat(i)); %,b0,sign_b
    
    
%     plant = tf(b_hat(i+1),[1 a_hat(i+1)]);
%     plant = ss(plant)
%     temp = lsim(plant, r(i)*u_1,t,yp(i))
%     yp(i+1)=temp(end);
    %yap = y actual plant
    temp = lsim(Gp_ss,r(i)*u_1,t,yap(i));
    yap(i+1) = temp(end);
end

a_hat(end)
b_hat(end)
figure()
plot(t_space,a_hat)
figure()
plot(t_space,b_hat)
% figure()
% plot(t_space,est_error)
% figure()
% plot(t_space,yp)
% figure()
% plot(t_space,z)
% hold on
% plot(t_space, theta_phi)