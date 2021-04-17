function [k1new, k2new] = calculate_k(gamma1,gamma2,e,y,t,k1_prev,k2_prev,sgnb)
 
 k1dot = gamma1*e^2*sgnb;
 temp = ode45(@(t,k)k1dot,t,k1_prev);
 k1new=temp.y(end);
 
 k2dot = gamma2*e*sgnb;
 temp2 = ode45(@(t,l)k2dot,t,k2_prev);
 k2new = temp2.y(end);
end