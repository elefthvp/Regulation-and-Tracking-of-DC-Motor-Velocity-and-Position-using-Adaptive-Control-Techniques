clear all;
close all;
%%%check controlabillity

%%
kM=235.68;
k0=0.2347;
kmu=0.0278;
Tm=0.564;
a=k0*kmu*kM;
numerator = a;
denominator = [Tm,1,0];
Gp= tf(numerator,denominator)
sys = ss(Gp)

A=sys.A;
B=sys.B;
C=sys.C;
D=sys.D;

% B = [0 b]'
% A= [0 1 ; -a 0]
% A=double(A)

%%
%check controllability
Co = ctrb(A,B)
unco = length(A) - rank(Co)
if(unco)
    disp('System is not controllable')
    quit()
end
%%
syms k1 k2
K = [k1 k2]

Atilde=A-B*K

%kr calculation
AtINV=inv(Atilde)
kr = 1/(-((C* AtINV) * B))
eigenvals=eig(Atilde)


p = [1 5 6]; %polynomial factors 
r = roots(p); %the poles will be placed there 

for i=1:length(eigenvals)
    eqns(i) = eigenvals(i)==r(i);
end

%%
strct = solve(eqns,[k1 k2])
k1 = double(strct.k1);
k2 = double(strct.k2);

%%
kr=double(subs(kr));
Atilde = double( subs(Atilde));
Bt = kr*B;
%% check that closed loop system works as desired
interval=0.275;
t_space = 0:interval:25;
r = 5;
r = r *ones(1,length(t_space))

sys = ss(Atilde,Bt,C,D);
[y,t]=lsim(sys,r,t_space,[0 0]);
rlocus(sys);

sys = ss(A,B,C,D)
save('theta_system_and_gains','k1','k2','kr','sys')


