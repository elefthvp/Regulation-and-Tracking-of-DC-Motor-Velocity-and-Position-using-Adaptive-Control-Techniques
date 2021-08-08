function [y_scalar,x1by2] = integrate_secondorder(system,input,t,init_cond)
%integrate a second-order system and return its last value
[tempy,t,tempx] = lsim(system, input,t,init_cond);
x1by2 = tempx(end,:);
y_scalar = tempy(end);
end

