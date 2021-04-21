function thetap_new = update_theta_p(t,Gamma,epsilon,phi,kp_min,thetap_prev)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
kpprev = thetap_prev(1);
for i =1:2
    if (i ==1 )
        if ( (kpprev < kp_min) || ((kpprev == kp_min) && (epsilon*phi(i) <= 0 )))
        thetap_dot = Gamma(i,i)*epsilon*phi(i); %needs minus?
        else
        thetap_dot = 0;
        end
    else
        thetap_dot = Gamma(i,i)*epsilon*phi(i);
    end
    temp = ode45(@(t,y)thetap_dot,t,thetap_prev(i));
    thetap_new(i)=temp.y(end);
        
end
end

