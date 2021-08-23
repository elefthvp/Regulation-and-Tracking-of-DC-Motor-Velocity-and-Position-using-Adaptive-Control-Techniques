function system = SecondOrderCCF(transfer_function)
[num,den] = tfdata(transfer_function)
b = cell2mat(num)
a = cell2mat(den)
A = [ 0 1;-a(3) -a(2)]
B = [0 1]';
C = [(b(3)-a(3)*b(1)) (b(2)-a(2)*b(1))]
D = b(1);
system = ss(A,B,C,D)
end