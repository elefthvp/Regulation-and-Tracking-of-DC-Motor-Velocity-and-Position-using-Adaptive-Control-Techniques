function mtrx = SylMtrx(p1,p2)
%% Homemade function that calculates Sylvester Matrix
% Input arguments in polynomial form
syms s
%%
[num,den] = tfdata(p1);
d = cell2mat(num);
n1 = length(d)
% p1poly = poly2sym(d,s);
% p1c = coeffs(p1poly);
p1c= d

[num,den]=  tfdata(p2);
d = cell2mat(num);
n2=length(d)
p2poly = poly2sym(d,s);
p2c = coeffs(p2poly);
p2c=cell2mat(num);

if(n1>n2)
    p2c= [zeros(1,n1-n2) p2c];
elseif (n1<n2)
    p1c= [zeros(1,n1-n2) p1c];
end


%% UPPER LEFT
ul = p1c(1)*eye(length(p1c)-1);
ul(:,1) = p1c(1:end-1)';
ul(end,:) = p1c(end-1:-1:1); %%swsto

%% LOWER LEFT
ll = p1c(end)*eye(length(p1c)-1);
ll(1,:) = p1c(end:-1:2);
ll(:,end) = p1c(2:end)';
for i=1:(length(p1c)-2)
    ll(i,i+1) = p1c(end-1);
end

%% UPPER RIGHT
ur = p2c(1)*eye(length(p2c)-1);
ur(:,1) = p2c(1:end-1)';
ur(end,:) = p2c(end-1:-1:1); %%swsto

%% LOWER RIGHT
lr = p2c(end)*eye(length(p2c)-1);
lr(1,:) = p2c(end:-1:2);
lr(:,end) = p2c(2:end)';
for i=1:(length(p2c)-2)
   
    lr(i,i+1) = p2c(end-1);
    
end

%% COMBINATION
mtrx = [ul ur ; ll lr];

end

 