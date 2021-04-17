%Q(s,t) calculation for Indirect MRAC with Normalization
syms s a1_hat lamda1 lamda0
p1 = s^2 + 5*s+10
p2 = s^2 + 13*s
[r,q] = polynomialReduce(p1,p2,s)

syms theta2 theta3 l1 lo kphat a1 s
[r,q] = polynomialReduce(p1,p2,s)

exp1 = theta2 +theta3*(s^2+l1*s+lo) == (1/kphat)*(s^2+a1*s - (s^2+1.5*s+2)*(s^2+l1*s+lo));
coeffs1 = coeffs(theta2 +theta3*(s^2+l1*s+lo),s)
coeffs2 = coeffs((1/kphat)*(s^2+a1*s - (s^2+1.5*s+2)*(s^2+l1*s+lo)),s)
% expr1 = coeffs1(2) == coeffs2(2)
% g = matlabFunction(solve(expr1,theta3))

solution = solve(exp1, [theta2 theta3])

t = 0:1:10;
u_1 = 2*ones(1,length(t));
A = [0 1;-3 -2]
B = [-2;1]
C = [1 0];
D = 1
testsystem = ss(A,B,C,D)
testtransf = tf([1 0 0],[1 2 3])

[yss,tOut,x] = lsim(testsystem,u_1,t);

ytf = lsim(testtransf,u_1,t);

testsystemss = ss(testtransf)
ytf2ss = lsim(testsystemss,u_1,t);

figure()
plot(t,yss)
hold on
plot(t,ytf)
plot(t,ytf2ss)
legend('yss','ytf','ytf2ss')

%Punchline: they are equivalent.