function out1 = calculate_theta3(a1_hat,kphat,lamda0,lamda1)
%CALCULATE_THETA3
%    OUT1 = CALCULATE_THETA3(A1_HAT,KPHAT,LAMDA0,LAMDA1)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    11-Apr-2021 20:59:09

out1 = -(lamda0.*(3.0./2.0)+lamda1.*2.0-a1_hat.*(lamda0+lamda1.*(3.0./2.0)-a1_hat.*(-a1_hat+lamda1+3.0./2.0)+2.0))./(kphat.*lamda1);
