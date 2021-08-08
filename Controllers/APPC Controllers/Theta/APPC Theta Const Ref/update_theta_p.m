function thetap_new = update_theta_p(t,Gamma,epsilon,phi,kp_min,thetap_prev)
% Parameter estimation of k,a using parameter projection to ensure that k
% does not drift to zero, causing a division by s.
kpprev = thetap_prev(1);
for i =1:2
    if (i ==1 )
        if ( (kpprev < kp_min) || ((kpprev == kp_min) && (epsilon*phi(i) <= 0 )))
        thetap_dot = Gamma(i,i)*epsilon*phi(i);
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

