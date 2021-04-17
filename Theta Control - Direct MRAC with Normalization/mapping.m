function [theta1,theta2, theta3] = mapping(Wm,Gp,n,Lamda,km,kp)
%the first part of Rm,Zm,Rp,Zp definition etc is identical to the previous
%function, and so is the polynomial reduce part. As far as the equation of
%respective s powers in both parts is concerned, what we do is bring all
%the terms in the left part, get the coeffs (as a means of factorization)
%and equate each coeff with zero. These new expressions contain thetai, i=1,2,3 as
%unknowns. We then solve a system of expressions with respect to these
%theta variables and return the results.
syms s theta1 theta2 theta3;

[num,den] = tfdata(Wm);
d = cell2mat(den);
R_m = (1/d(1))*poly2sym(d,s);

[num,den] = tfdata(Gp);
d = cell2mat(den);
R_p = (1/d(1))*poly2sym(d,s);
Z_p = 1;

p1= Lamda * R_m;
p2 = R_p;
[r,q] = polynomialReduce(p1,p2,s);
Q = q;

eqn1 = theta1 - (Lamda - Z_p*Q) == 0;

coeffs_1 = coeffs(lhs(eqn1),s);
syms eqns
count = 1;
for i=1:length(coeffs_1)
    eqns(count) = coeffs_1(i)==0
    count=count+1;
end

eqn2 = theta2 + theta3*Lamda -(1/kp)*(Q * R_p - Lamda*R_m) == 0;
coeffs_1 = coeffs(lhs(eqn2),s);

for i=1:length(coeffs_1)
    eqns(count) = coeffs_1(i)==0;
    count=count+1;
end


strct = solve(eqns,[theta1 theta2 theta3]);
theta1 = strct.theta1
theta2 = strct.theta2
theta3 = strct.theta3
end

