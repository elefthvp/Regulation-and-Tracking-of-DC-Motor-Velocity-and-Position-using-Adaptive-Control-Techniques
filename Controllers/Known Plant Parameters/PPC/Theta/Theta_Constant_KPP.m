%change yp at zeta, phi calculation to actual plant output (not the CE)

clear all
close all
%%
syms s
n=2;
% q=1;
interval = 0.6; %0.8 and 1.3 also work for faster convergence
t_space=[0:interval:200];
% kp_max = -0.1;

%% Time, Reference Input and Reference Model simulation
n=2;

syms c t;

ym = c;

[Qm,q] = calculate_Qm(ym);

Qmtf = tf([sym2poly(Qm)],1)

c=2;
t=t_space;
ym = double(subs(ym));
ym=ym*ones(1,length(t_space));

As =s^4+s^3+5*s^2+4*s+3;

Astf = tf([sym2poly(As)],1)
%% Plant Model definition for simulation purposes 
kM=250;
k0=0.2;
kmu=1/30;
Tm=0.5;
a=-k0*kmu*kM;
numerator = a;
denominator = [Tm,1,0];
Gpknown= tf(numerator,denominator);
[astar kstar] = calculate_a_k(Gpknown)
Gpknown = tf(kstar,[1 astar])
Gpknownss=ss(Gpknown);


up=zeros;
y=zeros(length(t_space),2);
yp=zeros(length(t_space),1);

%epsilon = zeros;

x = zeros(length(t_space),2*n+q-1); 
uic = zeros(length(t_space),n+q-1);

Rp = s^2-astar*s  %why -?
Zp = kstar
Rptf = tf([1 -astar 0],1)
Zptf = tf(kstar,1)
    
[Ps,Ls] = calculateP_L(n,q,As,Qmtf,Rptf,Zptf);
Cs = Ps/(Qmtf*Ls);
%% APPC Process
for i=2:length(t_space)
    t = t_space(i-1):0.1:t_space(i);
    u_1=ones(1,length(t));



 


    %% u and y update
    up_plant =  - Cs*(yp(i)-ym(i)) %no index because this is a tf
%     up_plant = ((Lamda - Ls*Qmtf)/Lamda)*up(i-1)-(Ps/Lamda)*(yp(i-1)-ym(i-1))
    up_plant = ss(up_plant)
    [temp,time,u0] = lsim(up_plant,u_1,t,uic(i,:))
    uic(i+1,:)=u0(end,:)
    up(i+1) = temp(end);
    
    %Calculating up (i+1) and simulating with the usual way does not bear
    %the right results in this one.
%     [temp,time,y0]= lsim(Gpknownss,up(i+1)*(u_1),t,y(i,:))
%     y(i+1,:)=y0(end,:)
%     yp(i+1) = temp(end);

    yp_plant = (Zptf*Ps/Astf)*ym(i) %this was x, i changed to yp_plant
    yp_plant = ss(yp_plant)
%     yp_plant = Gpknown*up(i+1);
%     yp_plant=ss(yp_plant);
    [temp,time,x0] = lsim(yp_plant,u_1,t,x(i,:))
    x(i+1,:)=x0(end,:)
    yp(i+1) = temp(end);
    
end
%%
figure()
plot(t_space(1:i),yp(1:i),t_space(1:i),ym(1:i))
title('yp and ym');
% e1=yp-ym;
% figure()
% plot(t_space,e1)




