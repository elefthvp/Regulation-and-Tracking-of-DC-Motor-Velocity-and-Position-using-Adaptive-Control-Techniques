clear all;
close all;
%%%check controlabillity

%%
km=235.68;
kT=0.0037;
Tm=0.564;
a =  1/Tm;
b = km*kT/Tm;
Gp = tf(b,[1 a])
sys = ss(Gp)
A =sys.A;
B = sys.B;
C = sys.C;
D = sys.D;

syms k1
Atilde = A - B*k1

AtINV=inv(Atilde)
kr = 1/(-((C* AtINV) * B))

eigenvals=eig(Atilde)

p = [1 5]; %polynomial factors 
r = roots(p);

for i=1:length(eigenvals)
    eqns(i) = eigenvals(i)==r(i);
end

strct = solve(eqns,k1)
k1 = double(strct);

kr=double(subs(kr));
Atilde = double( subs(Atilde));
Bt = kr*B;


interval=0.275;
t_space = 0:interval:25;
r = 5;
r = r *ones(1,length(t_space))

sys = ss(Atilde,Bt,C,D);
[y,t]=lsim(sys,r,t_space,[0]);
figure()
plot(t,y)
title('y')

rlocus(sys)

sys = ss(A,B,C,D)
save('system_and_gains','k1','kr','sys')