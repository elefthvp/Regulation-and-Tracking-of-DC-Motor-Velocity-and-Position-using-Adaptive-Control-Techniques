function system = ThirdOrderCCF(transfer_function)
[num,den] = tfdata(transfer_function)
b = cell2mat(num)
a = cell2mat(den)
A = [ 0 1 0; 0 0 1; -a(4) -a(3) -a(2)]
B = [0 0 1]';
C = [(b(4)-a(4)*b(1)) (b(3)-a(3)*b(1)) (b(2)-a(2)*b(1))]
D = b(1);
system = ss(A,B,C,D)
end

%na eksasfalisw oti o syntelestis tou prwtou stoixeiou tou paronomasti
%einai panta 1