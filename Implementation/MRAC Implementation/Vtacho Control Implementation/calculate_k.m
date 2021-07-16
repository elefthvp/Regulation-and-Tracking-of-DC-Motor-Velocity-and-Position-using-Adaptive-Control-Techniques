function k = calculate_k(transfer_function)
[num,den]=tfdata(transfer_function);
num = cell2mat(num);
den = cell2mat(den);
idx_n = find(num~=0, 1, 'first');
idx_d = find(den~=0, 1, 'first');
k=num(idx_n)/den(idx_d)

end

