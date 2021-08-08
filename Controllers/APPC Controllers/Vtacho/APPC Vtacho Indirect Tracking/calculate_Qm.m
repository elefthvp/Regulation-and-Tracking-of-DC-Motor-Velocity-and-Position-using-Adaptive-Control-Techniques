function [Qm,q] = calculate_Qm(ym)
%works generally for ym = c , ym=sint etc
syms c t;

if(ym == c)
    c=1;%any constant works
    ym = subs(ym);
end
res = laplace(ym);
[num,den] = numden(res);
den = expand(den);
Qm = den;
q=length(sym2poly(den))-1;
end
