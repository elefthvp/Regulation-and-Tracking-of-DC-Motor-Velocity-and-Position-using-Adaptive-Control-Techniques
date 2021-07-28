function [a_hat_new, b_hat_new] = calculate_a_b(gamma1,gamma2,e,x,u,t,a_hat_prev,b_hat_prev,b0,sign_b,M0,q0,sigma0)
%
sigma_s(1)=switching_modification(a_hat_prev,M0(1),q0(1),sigma0(1)); %einai ta M0,sigma0,q0 idia gia ta k,l?
sigma_s(2)=switching_modification(b_hat_prev,M0(2),q0(2),sigma0(2));

%a_hat calculation
a_hat_dot = gamma1*e*x;
temp = ode45(@(t,k)a_hat_dot-sigma_s(1)*gamma1*k,t,a_hat_prev);
%
a_hat_new=temp.y(end);


%b_hat calculation using Projection
%  expr = ( abs(b_hat_prev) > b0 ) | (abs(b_hat_prev) == b0 & e*u*sign(b_hat_prev) >=0);
%  ldot = -gamma2*e*r*sign_b;

 if ( (b_hat_prev > b0) || ((b_hat_prev == b0) &&  (e*u*sign_b >= 0 )))
        b_hat_dot = gamma2*e*u;
        temp = ode45(@(t,k)b_hat_dot-sigma_s(2)*gamma2*k,t,b_hat_prev);
        
        b_hat_new=temp.y(end);
 else
        b_hat_dot = 0;
        temp = ode45(@(t,k)b_hat_dot-sigma_s(2)*gamma2*k,t,b_hat_prev);
        
        b_hat_new=temp.y(end);
        
 end
 


 
end