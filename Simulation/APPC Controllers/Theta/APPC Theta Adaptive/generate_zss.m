function system = generate_zss(lamda0,lamda1)
%state-space representaton of s^2/Lamda as calculated in paper and pencil
A = [0 1; -lamda0 -lamda1];
B = [-lamda1 ;(lamda1^2 - lamda0)];
C = [1 0];
D = 1;
system = ss(A,B,C,D);
end

