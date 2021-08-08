function [ahatnew, bhatnew] = calculate_a_b(gamma1,gamma2,e,y,u,t,ahat_prev,bhat_prev,b0,sgnb)
 %a, b estimation for each time instant, parameter projection has been
 %employed to avoid possible drift to zero and division by zero
 ahatdot = gamma1*e*y;
 temp = ode45(@(t,a) ahatdot,t,ahat_prev);
 ahatnew=temp.y(end);
 
 if((bhat_prev>b0) || ((bhat_prev == b0) && (e*u*sgnb >=0)))
    bhatdot = gamma2*e*u;
 else
    bhatdot = 0;
 end
 temp2 = ode45(@(t,l)bhatdot,t,bhat_prev);
 bhatnew = temp2.y(end);
end