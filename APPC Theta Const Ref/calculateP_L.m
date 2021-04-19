function [Ps, Ls] = calculateP_L(n,q,A,Qm,Rp,Zp)
    %2n+q-2 coefficients of A
    Poly_coeffs = sym2poly(A);
    a = Poly_coeffs(2:end);

    %Sylvester Matrix Calculation
    temp = Qm*Rp;
    syl = SylMtrx(Qm*Rp,Zp);
    
    %calculate bl according to 6.33
    al = [zeros(1,q),1,a] ;
    bl = inv(syl)*al';
    bl=bl';
    
    %
    lq = bl(1:n+q);
    Ls = generate_a_s(n-1);
    l = lq(3:end)';
    lmult=[1 l];
    Ls = lmult*Ls;
    %
    p = bl(n+q+1:end);
    Ps = generate_a_s(n+q-1);
    Ps = p*Ps;

    Ls =  tf([sym2poly(Ls)],1);
    Ps =  tf([sym2poly(Ps)],1);
end