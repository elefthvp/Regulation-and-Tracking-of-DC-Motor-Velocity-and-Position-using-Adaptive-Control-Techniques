function theta_new = solvethetadot(Gamma,epsilon,phi,theta_prev,sgn,t)
    for j=1:length(Gamma)
    theta_dot=Gamma(j,j)*epsilon*phi(j)*sgn;
    temp = ode45(@(t,y)theta_dot,t,theta_prev(j));
    theta_new(j)=temp.y(end);
    end
end

%add sgn
%ode45(@(t,y) -2*y+6,t,y0)
