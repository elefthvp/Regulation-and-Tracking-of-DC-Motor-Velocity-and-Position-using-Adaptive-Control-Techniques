function [theta1,theta2, theta3] = mapping(Wm,Gp,n,Lamda,km,kp)
%As far as the equation of
%respective s powers in both parts is concerned, what we do is bring all
%the terms in the left part, get the coeffs (as a means of factorization)
%and equate each coeff with zero. These new expressions contain thetai, i=1,2,3 as
%unknowns. We then solve a system of expressions with respect to these
%theta variables and return the results.
syms s theta1 theta2 theta3;

%extract numerator and denominator of transfer functions to use in
%mathematical calculations 
[num,den] = tfdata(Wm);
d = cell2mat(den);
R_m = (1/d(1))*poly2sym(d,s);

[num,den] = tfdata(Gp);
d = cell2mat(den);
R_p = (1/d(1))*poly2sym(d,s);
Z_p = 1;

%Lamda*R_m/R_p calculation according to the methodology
p1= Lamda * R_m;
p2 = R_p;
[r,q] = polynomialReduce(p1,p2,s);
Q = q;

%eqn1 and eqn2 are the two equations from which the theta vector will be
%calculated, according to the theoretical analysis
%eqns contains the total system equations

eqn1 = theta1 - (Lamda - Z_p*Q) == 0;

coeffs_1 = coeffs(lhs(eqn1),s);
syms eqns
count = 1;
for i=1:length(coeffs_1)
    eqns(count) = coeffs_1(i)==0;
    count=count+1;
end

eqn2 = theta2 + theta3*Lamda -(1/kp)*(Q * R_p - Lamda*R_m) == 0;
coeffs_1 = coeffs(lhs(eqn2),s);

for i=1:length(coeffs_1)
    eqns(count) = coeffs_1(i)==0;
    count=count+1;
end

%solve system
strct = solve(eqns,[theta1 theta2 theta3]);

%return values
theta1 = strct.theta1
theta2 = strct.theta2
theta3 = strct.theta3
end

