function system = generate_zss(lamda0,lamda1)
A = [0 1; -lamda0 -lamda1];
B = [-lamda1 ;(lamda1^2 - lamda0)];
C = [1 0];
D = 1;
system = ss(A,B,C,D);
end

