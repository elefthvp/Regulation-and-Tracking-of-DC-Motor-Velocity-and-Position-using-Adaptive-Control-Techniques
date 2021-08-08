function [y_scalar,x1by2] = integrate_secondorder(system,input,t,init_cond)
%simulate a second order system using lsim and return the last value of the
%response
[tempy,t,tempx] = lsim(system, input,t,init_cond);
x1by2 = tempx(end,:);
y_scalar = tempy(end);
end

