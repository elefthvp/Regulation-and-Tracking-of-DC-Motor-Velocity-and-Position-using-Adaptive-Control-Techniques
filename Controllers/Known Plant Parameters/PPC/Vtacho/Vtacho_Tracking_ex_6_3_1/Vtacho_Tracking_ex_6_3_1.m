%%works for a first order plant and a sinusoid reference
%yp has to be y of actual plant after simulation
% does not work for a constan reference as the eq_6_31 solver is made to
% return p2, p1, p0 and in my case I only need a p0, p1. I try using it to
% solve for p0, p1 and the results are wrong compared to the book. This is
% because the eq_6_31 solver file is probably hardwired.
%All in all this doesn't respond half as good as the k1-2-3 star controller
%I proved on my own.
%%
clear all
close all
%% Simulation time definition
% interval=0.1;
t_space = 0:interval:15;

%%
syms s
n=1;
% q=1;
syms c t;
ym = c;
ym = sin(0.25*t)
[Qm,q] = calculate_Qm(ym);
% Qm = (s^2+0.2^2)
Qmtf = tf([sym2poly(Qm)],1)
% q=3;
% c=2;
t=t_space;
ym = double(subs(ym));
% ym=c*ones(1,length(t_space));



%% As definition, As is a design paramater/desired polynomial
As =s^3 + 3*s^2+2*s+4;
%
Astf = tf([sym2poly(As)],1);

eq_6_31(n,q,Qm,As) % generates the p functions
%% Plant definition
km=235.68;
kT=0.0037;
Tm=0.564;
a = + 1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a]);
Gp_ss = ss(Gp);
% b0=0.2;
% sign_b = sign(b);



up=zeros(length(t_space),1);
yp=zeros(length(t_space),1);
up(1)=0.1;

 
e(1)=0;

%% estimation error calculation
lamda = 2;
lamda1 = 3;
Lamda = tf([1 lamda1 lamda],1); %degree n+q-1


x = zeros(length(t_space),2*n+q-1);
uic = zeros(length(t_space),4); %save initial conditions
ym(1)=0.1 %initialize so that first yp simulation isn't a 1-state system  

%%
p0star = calculate_p0(a,b) %minus possibly has to do with how the calculate p functions where created
p1star = calculate_p1(b)
p2star = calculate_p2(a,b)

Rp = s+a;
Zp = b;
Rptf = tf([1 a],1);
Zptf = tf(b,1);
    
Ps = tf([p2star p1star p0star],1)
Ls = tf(1)


%%
for i=1:(length(t_space)-1)

    t = t_space(i):interval:t_space(i+1);
    u_1 = ones(1,length(t));
    %adaptive law
   %estimtion error parameters
%     z(i+1) = simulate_first_order(z_ss,yp(i)*u_1,t,z(i));
%     xsl(i+1) = simulate_first_order(lamda_inv_ss,-yp(i)*u_1,t,xsl(i)); %mind the minus here, possibly not needed
%     usl(i+1) = simulate_first_order(lamda_inv_ss,up(i)*u_1,t,usl(i));
%     theta_phi(i+1) = a_hat(i)*xsl(i+1) + b_hat(i)*usl(i+1);
%     ms_squared = 1+[xsl(i+1) usl(i+1)]*[xsl(i+1) usl(i+1)]';
%     est_error(i+1) = (z(i+1) - theta_phi(i+1))/ms_squared;

%    [a_hat(i+1), b_hat(i+1)] = calculate_a_b(gamma1,gamma2,est_error(i+1),xsl(i+1),usl(i+1),t,a_hat(i),b_hat(i),b0,sign_b);
   
    e1(i)=yp(i)-ym(i)
   
    up_plant =  ((Lamda - Ls*Qmtf)/Lamda)*up(i)-(Ps/Lamda)* e1(i)
    up_plant = ss(up_plant);
    [temp,time,u0] = lsim(up_plant,u_1,t,uic(i,:));
    uic(i+1,:)=u0(end,:);
    up(i+1) = temp(end);
    
    
    yp_plant = (Zptf*Ps/Astf)*ym(i);
    yp_plant = ss(yp_plant);
    [temp,time,x0] = lsim(yp_plant,u_1,t,x(i,:));
    x(i+1,:)=x0(end,:);
    yp(i+1) = temp(end);
 
 end
%%
plot(t_space,yp)
hold on
plot(t_space,ym)
hold off
