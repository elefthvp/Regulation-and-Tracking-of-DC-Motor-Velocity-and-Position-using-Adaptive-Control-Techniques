function [k_new, l_new] = calculate_k_l(gamma1,gamma2,e,x,r,t,k_l_prev,sign_b)
 %Adaptive Law for k, l calculation 
 kdot = gamma1*e*x*sign_b;
 temp = ode45(@(t,k)kdot,t,k_l_prev(1));
 k_new=temp.y(end);
 
 ldot = -gamma2*e*r*sign_b;
 temp2 = ode45(@(t,l)ldot,t,k_l_prev(2));
 l_new = temp2.y(end);
end