function system = generate_phi2ss(lamda0,lamda1)
%state-space representaton of -s/Lamda as calculated in paper and pencil
A = [0 1; -lamda0 -lamda1];
B = [-1 ;lamda1];
C = [1 0];
D = 0;
system = ss(A,B,C,D);
end

