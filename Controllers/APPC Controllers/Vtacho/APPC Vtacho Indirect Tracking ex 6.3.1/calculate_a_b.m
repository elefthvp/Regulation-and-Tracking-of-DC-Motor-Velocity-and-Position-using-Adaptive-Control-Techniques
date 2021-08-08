function [a_hat_new, b_hat_new] = calculate_a_b(gamma1,gamma2,e,x,u,t,a_hat_prev,b_hat_prev,b0,sign_b)

%a_hat calculation
a_hat_dot = gamma1*e*x;
temp = ode45(@(t,k)a_hat_dot,t,a_hat_prev);
a_hat_new=temp.y(end);


%b_hat calculation using Projection
 if ( (b_hat_prev > b0) || ((b_hat_prev == b0) &&  (e*u*sign_b >= 0 )))
        b_hat_dot = gamma2*e*u;
 else
        b_hat_dot = 0;
 end
 
 temp = ode45(@(t,k)b_hat_dot,t,b_hat_prev);
 b_hat_new=temp.y(end);

 
end