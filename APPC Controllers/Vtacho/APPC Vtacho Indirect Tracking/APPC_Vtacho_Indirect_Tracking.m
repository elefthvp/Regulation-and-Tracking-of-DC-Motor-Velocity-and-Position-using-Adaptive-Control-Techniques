clear all
close all
%% Simulation time definition
interval=0.1;
t_space = 0:interval:30;

%%
syms s
n=1;
% q=1;
syms c t;
% ym = c;
ym = sin(t)
[Qm,q] = calculate_Qm(ym);
% Qm = s*(s^2+0.2^2)
Qmtf = tf([sym2poly(Qm)],1)
% q=3;
% c=2;
t=t_space;
ym = double(subs(ym));
% ym=c*ones(1,length(t_space));



%% As definition
As =s^2+4*s+3;
%s^4+s^3+5*
Astf = tf([sym2poly(As)],1);

%% Plant definition
km=250;
kT=0.004;
Tm=0.5;
a = + 1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
Gp_ss = ss(Gp);
b0=0.2;
sign_b = sign(b);

gamma1=0.3; 
gamma2=0.3;

% yp=zeros; %yp(0) = xm(0) = 0
% % k=zeros;
% l=zeros;

up=zeros;
yp=zeros(length(t_space),1);


% lamda0 = 2;

a_hat(1)= 0;
b_hat(1) = 2; 
e(1)=0;

%% estimation error calculation
lamda = 2;
tf_z = tf([1 0],[1 lamda]);
z_ss = ss(tf_z);

tf_Lamda_inv = tf(1,[1 lamda]);
lamda_inv_ss = ss(tf_Lamda_inv);

z=zeros;
xsl=zeros;
usl=zeros;
est_error=zeros;

x = zeros(length(t_space),2*n+q-1);
uic = zeros(length(t_space),n+q-1);
% i=1
for i=1:(length(t_space)-1)
% i=1;
    t = t_space(i):interval:t_space(i+1);
    u_1 = ones(1,length(t));
    %adaptive law
   %estimtion error parameters
    z(i+1) = simulate_first_order(z_ss,yp(i)*u_1,t,z(i));
    xsl(i+1) = simulate_first_order(lamda_inv_ss,yp(i)*u_1,t,xsl(i));
    usl(i+1) = simulate_first_order(lamda_inv_ss,up(i)*u_1,t,usl(i));
    theta_phi(i+1) = -a_hat(i)*xsl(i+1) + b_hat(i)*usl(i+1);
    ms_squared = 1+[-xsl(i+1) usl(i+1)]*[-xsl(i+1) usl(i+1)]';
    est_error(i+1) = (z(i+1) - theta_phi(i+1))/ms_squared;

   [a_hat(i+1), b_hat(i+1)] = calculate_a_b(gamma1,gamma2,est_error(i+1),-xsl(i+1),usl(i+1),t,a_hat(i),b_hat(i),b0,sign_b);
   
    Rp = s+a_hat(i+1);
    Zp = b_hat(i+1);
    Rptf = tf([1 a_hat(i+1)],1);
    Zptf = tf(b_hat(i+1),1);
    
    [Ps,Ls] = calculateP_L(n,q,As,Qmtf,Rptf,Zptf);
    Cs = Ps/(Qmtf*Ls); %find ss model manually?

    %% up and y update
    up_plant =  - Cs*(yp(i)-ym(i)); %no index because this is a tf
%     up_plant = ((Lamda - Ls*Qmtf)/Lamda)*up(i-1)-(Ps/Lamda)*(yp(i-1)-ym(i-1))
    up_plant = ss(up_plant);
    [temp,time,u0] = lsim(up_plant,u_1,t,uic(i,:));
    uic(i+1,:)=u0(end,:);
    up(i+1) = temp(end);
    
    
    yp_plant = (Zptf*Ps/Astf)*ym(i);
    yp_plant = ss(yp_plant);
    [temp,time,x0] = lsim(yp_plant,u_1,t,x(i,:));
    x(i+1,:)=x0(end,:);
    yp(i+1) = temp(end);
   disp(i)
 
 end

plot(t_space,yp)
hold on
plot(t_space,ym)
