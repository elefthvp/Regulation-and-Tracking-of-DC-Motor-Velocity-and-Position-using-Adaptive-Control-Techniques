%change yp at zeta, phi calculation to actual plant output (not the CE)
clear all
close all
%%
syms s
n=2;
interval = 0.01;
t_space=[0:interval:10];
kp_max = -0.1;

%% Time, Reference Input and Reference Model simulation
n=2;
% ym = 2 + sin(t_space);
syms c t;
c=1;
ym = sin(c*t);

[Qm,q] = calculate_Qm(ym);
Qmtf = tf([sym2poly(Qm)],1);

t=t_space;
ym = 2*double(subs(ym));

As =s^5+3*s^4+s^3+5*s^2+4*s+3;
Astf = tf([sym2poly(As)],1);
%% Plant Model definition for simulation purposes 
kM=235.68;
k0=0.2347;
kmu=1/36;
Tm=0.564;
a=-k0*kmu*kM;
numerator = a;
denominator = [Tm,1,0];
Gpknown= tf(numerator,denominator);
Gpknownss=ss(Gpknown);


up=zeros;
y=zeros(length(t_space),2);
yp=zeros(length(t_space),1);

lamda1 = 4;
lamda0 = 4;
%% Adaptive Law variables initialization
Lamda_inv_tf = tf(1, [1 lamda1 lamda0]);
Lamda_inv_ss = ss(Lamda_inv_tf); %%CHECK AGAIN
Lamda = tf([1 2 3 4],1)

%z = s^2/Lamda
zss = generate_zss(lamda0,lamda1);
z1z2 = zeros(length(t_space),2);
z=zeros(length(t_space),1);
%phi2
phi2_ss = generate_phi2ss(lamda0,lamda1);
phi_1_ic = zeros(length(t_space),2);
phi_2_ic = zeros(length(t_space),2);
phi_1 = zeros(length(t_space));
phi_2 = zeros(length(t_space));


%% theta_p = zeros(length(t_space),2);
kphat = zeros;
kphat(1) = -1;
a1_hat = zeros;
phi = zeros(2,length(t_space));
ms_squared = zeros;
epsilon = zeros;
theta_p(1,:) = [kphat(1) 0];

gamma = 0.35;
Gamma = gamma*eye(length(theta_p(1,:)));
x = zeros(length(t_space),2); 
%2*n+q-1
uic = zeros(length(t_space),n+q-1);
%n+q-1
ym(1)=0.04; %to avoid system going to zero during 

%% APPC Process
for i=2:length(t_space)
    t = t_space(i-1):0.002:t_space(i);
    u_1=ones(1,length(t));

    % adaptive law
    %z
    [z(i),z1z2(i,:)] = integrate_secondorder(zss, yp(i)*u_1,t,z1z2(i-1,:));
    
    %phi
    [phi_1(i) , phi_1_ic(i,:)] = integrate_secondorder(Lamda_inv_ss, up(i-1)*u_1, t,phi_1_ic(i-1,:)); %kp
    [phi_2(i) , phi_2_ic(i,:)] = integrate_secondorder(phi2_ss , yp(i)*u_1,t,phi_2_ic(i-1,:)); %a, phi2ss needs to include a minus
    %i checked that it exists by going in the function and using ss2tf to
    %see the transfer function has a minus in the nominator part
    phi(:,i) = [ phi_1(i) ; phi_2(i)];
    
    ms_squared(i) = 1+ phi(:,i)' * phi(:,i);
    
    epsilon(i) = (z(i) - theta_p(i-1,:) * phi (:,i))/ms_squared(i);

    theta_p(i,:) = update_theta_p(t,Gamma,epsilon(i),phi(:,i),kp_max,theta_p(i-1,:));
    kphat(i) = theta_p(i,1);
    a1_hat(i) = theta_p(i,2); %NO PROJECTION NEEDED HERE

 
    % control law
    %calculate sylvester matrix, L and P here!
    Rp = s^2+a1_hat(i)*s;
    Zp = kphat(i) ;
    Rptf = tf([1 +a1_hat(i) 0],1);
    Zptf = tf(kphat(i),1);
    
    [Ps,Ls] = calculateP_L(n,q,As,Qmtf,Rptf,Zptf);
    Cs = Ps/(Qmtf*Ls);
    
    % u and y update
    up_plant =  - Cs*(yp(i)-ym(i)) %no index because this is a tf
%   up_plant = ((Lamda - Ls*Qmtf)/Lamda)*up(i-1)-(Ps/Lamda)*(yp(i-1)-ym(i-1))
%   up_plant = ss(up_plant)
    up_plant = ThirdOrderCCF(up_plant);
    [temp,time,u0] = lsim(up_plant,u_1,t,uic(i,:));
    uic(i+1,:)=u0(end,:)
    up(i+1) = temp(end);
    
%     yp_plant = (Zptf*Ps/Astf)*ym(i) ;%this was x, i changed to yp_plant
%     yp_plant = FifthOrderCCF(yp_plant);
   
    [temp,time,x0] = lsim(Gpknownss,up(i+1)*u_1,t,x(i,:))
    x(i+1,:)=x0(end,:)
    yp(i+1) = temp(end);
end
 %%
% e1=yp-ym;
figure()
plot(t_space(1:i),yp(1:i),t_space(1:i),ym(1:i))
legend('yp','ym')
xlim([0 6])
plot(t_space,yp(1:end-1),t_space,ym)
figure()
plot(a1_hat)
figure()
plot(kphat)
% figure()
% plot(t_space,e1)
% figure()
% plot(t_space(2:i+1),a1_hat)
% figure()
% plot(t_space(2:i+1),kphat)
% 
% 
% figure()
% plot(t_space(2:end),epsilon)

% save workspace.mat
