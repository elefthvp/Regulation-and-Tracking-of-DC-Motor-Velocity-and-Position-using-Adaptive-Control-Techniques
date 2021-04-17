function [k1new, k2new,k3new] = calculate_k(gamma1,gamma2,gamma3,e,ym,ymdot,t,k1_prev,k2_prev,k3_prev,sgnb)
 
 k1dot = gamma1*e^2*sgnb;
 temp = ode45(@(t,k)k1dot,t,k1_prev);
 k1new=temp.y(end);
 
 k2dot = gamma2*e*ym*sgnb;
 temp = ode45(@(t,k)k2dot,t,k2_prev);
 k2new = temp.y(end);
 
 k3dot = gamma3*e*ymdot*sgnb;
 temp = ode45(@(t,k)k3dot,t,k3_prev);
 k3new = temp.y(end);
 
end