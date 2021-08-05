function [y_scalar,x1by2] = integrate_secondorder(system,input,t,init_cond)

[tempy,t,tempx] = lsim(system, input,t,init_cond);
x1by2 = tempx(end,:);
y_scalar = tempy(end);
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
end

