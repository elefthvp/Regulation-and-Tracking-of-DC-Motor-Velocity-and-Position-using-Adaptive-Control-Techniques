function k_m = matching_equations(Wm,n,k_m,kp)
%As far as the equation of
%respective s powers in both parts is concerned, what we do is bring all
%the terms in the left part, get the coeffs (as a means of factorization)
%and equate each coeff with zero. These new expressions contain thetai, i=1,2,3 as
%unknowns. We then solve a system of expressions with respect to these
%theta variables and return the results.
n = 2;

syms s theta1 theta2 theta3 lamda1 lamda0 a1_hat kphat

%extract numerator and denominator of transfer functions to use in
%mathematical calculations 
[num,den]=tfdata(Wm);
d = cell2mat(den);
R_m = (1/d(1))*poly2sym(d,s);
% k_m = (1/d(1));

R_p = s^2+a1_hat*s;
Z_p = 1;


Lamda = lamda1*s+lamda0; %designer parameter s^2+

a_s=zeros;
if (n>2)
    for i=2:n
    a_s=[s^(i-2); a_s];
    end
    a_s=a_s(1:end-1);
else
    a_s= s^(n-2);
end

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

eqn2 = theta2 + theta3*Lamda -(1/kphat)*(Q * R_p - Lamda*R_m) == 0;
coeffs_1 = coeffs(lhs(eqn2),s);

for i=1:length(coeffs_1)
    eqns(count) = coeffs_1(i)==0;
    count=count+1;
end

%solve system
strct = solve(eqns,[theta1 theta2 theta3]);

%return values
matlabFunction(strct.theta3,'File','calculate_theta3');
matlabFunction(strct.theta2,'File','calculate_theta2');
matlabFunction(strct.theta1,'File','calculate_theta1');

end

