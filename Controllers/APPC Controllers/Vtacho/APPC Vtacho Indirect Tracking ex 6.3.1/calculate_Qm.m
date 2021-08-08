function [Qm,q] = calculate_Qm(ym)
syms c t;
% ym = c+sin(t)
if(ym == c)
    c=1;%any constant works
    ym = subs(ym);
end
res = laplace(ym);
[num,den] = numden(res);
den = expand(den);
%get rid of the non unit factor in front of s^2 when w<1 (w=sin frequency)
divide=coeffs(den)
den=den/divide(end)

Qm = den;
q=length(sym2poly(den))-1;
end

