function eq_6_31(n,q,Q,As)
%solves equations 6.31 and generates the functions that calculate p0,p1,p2
syms s p2 p1 p0 a b
L = 1
P = p2*s^2+p1*s+p0

Rp=s+a
Zp = b

eq1 = L*Q*Rp+P*Zp - As
eqns = coeffs(expand(eq1),s) ==0

strct = solve(eqns,[p0 p1 p2])

%generate functions
matlabFunction(strct.p0,'File','calculate_p0')
matlabFunction(strct.p1,'File','calculate_p1')
matlabFunction(strct.p2,'File','calculate_p2')

end