function system = FifthOrderCCF(transfer_function)
[num,den] = tfdata(transfer_function)
a = cell2mat(den);
b = cell2mat(num);
k = find(b,length(b),'first');
b=b(k(1:end));
if(length(b)==length(a))
    disp('***************************WRONG SS MODEL******************'); %check if my ss modelling becomes invalid 
end
% b = b(3:end);
A = [ 0 1 0 0 0; 0 0 1 0 0; 0 0 0 1 0; 0 0 0 0 1; -a(6) -a(5) -a(4) -a(3) -a(2)];
B = [0 0 0 0 1]';
rel_degree = length(a)-length(b);
C = [fliplr(b) zeros(1,rel_degree-1)];
%C = [b(4) b(3) b(2) b(1)]
D = 0;
system = ss(A,B,C,D);
end
