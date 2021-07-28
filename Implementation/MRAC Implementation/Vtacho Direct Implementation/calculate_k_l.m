function [k_new, l_new] = calculate_k_l(gamma1,gamma2,e,x,r,t,k_l_prev,sign_b,M0,q0,sigma0)
 sigma_s(1)=switching_modification(k_l_prev(1),M0(1),q0(1),sigma0(1)); %einai ta M0,sigma0,q0 idia gia ta k,l?
 sigma_s(2)=switching_modification(k_l_prev(2),M0(2),q0(2),sigma0(2));
 % q0>=1
 % M0>|thetastar| (k,l)
 % sigma0>0
 kdot = gamma1*e*x*sign_b;
 temp = ode45(@(t,k)kdot-sigma_s(1)*gamma1*k,t,k_l_prev(1));
 k_new=temp.y(end);
 
 ldot = -gamma2*e*r*sign_b;
 temp2 = ode45(@(t,l)ldot-sigma_s(2)*gamma2*l,t,k_l_prev(2));
 l_new = temp2.y(end);
end