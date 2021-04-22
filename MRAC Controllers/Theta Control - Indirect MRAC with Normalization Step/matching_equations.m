function k_m = matching_equations(Wm,n,k_m,kp)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
n = 2;
% numerator = 1;
% denominator = [2 3 4];
% Wm = tf(numerator,denominator);


syms s theta1 theta2 theta3 lamda1 lamda0 a1_hat kphat
%upgrade to tf to sym maybe
[num,den]=tfdata(Wm);
d = cell2mat(den);
R_m = (1/d(1))*poly2sym(d,s);
% k_m = (1/d(1));

R_p = s^2+a1_hat*s;
Z_p = 1;


Lamda = s^2+lamda1*s+lamda0; %designer 

a_s=zeros;
if (n>2)
    for i=2:n
    a_s=[s^(i-2); a_s];
    end
    a_s=a_s(1:end-1);
else
    a_s= s^(n-2);
end

p1= Lamda * R_m;
p2 = R_p;
[r,q] = polynomialReduce(p1,p2,s);
Q = q;

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

count = 0;
syms eqns_f
for i=1:length(eqns)
    if((has(eqns(i),theta1) || has(eqns(i),theta2) || has(eqns(i),theta3)) && length(children(lhs(eqns(i))))~=1)
        count = count+1;
        eqns_f(count) = eqns(i);
    end
end

strct = solve(eqns_f,[theta1 theta2 theta3]);
matlabFunction(strct.theta3,'File','calculate_theta3');
matlabFunction(strct.theta2,'File','calculate_theta2');
matlabFunction(strct.theta1,'File','calculate_theta1');

end

