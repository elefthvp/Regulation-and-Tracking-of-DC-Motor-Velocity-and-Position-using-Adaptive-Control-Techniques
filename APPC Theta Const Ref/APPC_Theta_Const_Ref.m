n=2;
interval = 0.01;
t_space=[0:interval:30];

%% Time, Reference Input and Reference Model simulation

n=2;
interval = 0.01;
t_space=[0:interval:30];
c=4
ym=c*ones(1,length(t_space));

%% Plant Model definition for simulation purposes 
kM=250;
k0=0.2;
kmu=1/30;
Tm=0.5;
a=-k0*kmu*kM;
numerator = a;
denominator = [Tm,1,0];
Gpknown= tf(numerator,denominator);

% syms s ahat bhat
% Qm = s;
% Zp = bhat;
% Rp = s^2+ahat*s

bla = SylMtrx(Qm*Rp,Zp)

up=zeros;
y=zeros(length(t_space),2);
yp=zeros;

%% Control Law variables initialization
theta=zeros(length(t_space),4);
w=zeros(4,length(t_space));
theta1=zeros;
theta2=zeros;
theta3=zeros;
c0=zeros;
c0(1) = k_m/kphat(1);
theta=[0 0 0 c0(1)];
w = [0 0 0 r(1)]';

%% Adaptive Law variables initialization
Lamda_inv_tf = tf(1, [1 lamda1 lamda0]);
Lamda_inv_ss = ss(Lamda_inv_tf); %%CHECK AGAIN
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

%% APPC Process
for i=1:(length(t_space)-1)
    t = t_space(i):0.1:t_space(i+1);
    u_1=ones(1,length(t));

    up(i)= %DEFINE FORMULA FOR APPC CONTROL

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

    theta_p(i+1,:) = update_theta_p(t,Gamma,epsilon(i+1),phi(:,i+1),kp_max,theta_p(i,:));
    kphat(i+1) = theta_p(i+1,1);
    a1_hat(i+1) = theta_p(i+1,2); %NO PROJECTION NEEDED HERE

 
    %control law
    %calculate stuff like sylvester matrix, L, P etc here!
    %make this a function
    Rp = tf([1 ahat(i+1) 0],1)
    Zp = tf(bhat(i+1),1)
    temp = Qm*Rp
    syl = SylMtrx(Qm*Rp,Zp)

%     bl = inv(syl)* [0, (5 4 3 2)']'
    al = [zeros(1,q),1,a] %isxyei?
    bl = inv(syl)*al'
    bl=bl'
    lq = bl(1:n+q)
    l = lq(3:end)'

    p = bl(n+q+1:end)
    Ls = [s^n-1 



    


end