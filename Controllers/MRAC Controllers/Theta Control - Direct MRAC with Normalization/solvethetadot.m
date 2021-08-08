function theta_new = solvethetadot(Gamma,epsilon,phi,theta_prev,sgn,t)
%integration of the theta dot vector to decide its next value
    for j=1:length(Gamma)
    theta_dot=Gamma(j,j)*epsilon*phi(j)*sgn;
    temp = ode45(@(t,y)theta_dot,t,theta_prev(j));
    theta_new(j)=temp.y(end);
    end
end

