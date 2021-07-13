function [Qm,q] = calculate_Qm(ym)
%works generally for ym = c , ym=
syms c t;
% ym = c+sin(t)
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

%[n,d]=numden(laplace(poly2sym(5))) maybe switching to that will suffice
%for a more generalized case