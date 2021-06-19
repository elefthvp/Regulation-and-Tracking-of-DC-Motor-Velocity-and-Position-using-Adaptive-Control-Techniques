function out1 = calculate_theta3(a1_hat,kphat,lamda0,lamda1)
%CALCULATE_THETA3
%    OUT1 = CALCULATE_THETA3(A1_HAT,KPHAT,LAMDA0,LAMDA1)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    20-Jun-2021 02:42:40

t2 = a1_hat.^2;
out1 = (a1_hat.*4.0-lamda0.*3.0-lamda1.*4.0-t2.*3.0+a1_hat.*lamda0.*2.0+a1_hat.*lamda1.*3.0+a1_hat.*t2.*2.0-lamda1.*t2.*2.0)./(kphat.*lamda1.*2.0);
