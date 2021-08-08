function [theta1,theta2, theta3] = theta_star_mapping(Wm,Gp,n,Lamda,km,kp)
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
syms eqns;
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

count = 0;
syms eqns_f;
for i=1:length(eqns)
    if((has(eqns(i),theta1) || has(eqns(i),theta2) || has(eqns(i),theta3)) && length(children(lhs(eqns(i))))~=1)
        count = count+1;
        eqns_f(count) = eqns(i);
    end
end

%solve system
strct = solve(eqns_f,[theta1 theta2 theta3]);

%return values
theta1 = strct.theta1;
theta2 = strct.theta2;
theta3 = strct.theta3;
end