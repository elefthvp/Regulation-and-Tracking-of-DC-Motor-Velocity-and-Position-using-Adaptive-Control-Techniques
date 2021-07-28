function theta_new = solvethetadot(Gamma,epsilon,phi,theta_prev,sgn,t,M0,q0,sigma0)
    for j=1:length(Gamma)
    sigma_s(j)=switching_modification(theta_prev(j),M0(j),q0(j),sigma0(j));
    theta_dot=Gamma(j,j)*epsilon*phi(j)*sgn;
    temp = ode45(@(t,y)theta_dot-sigma_s(j)*Gamma(j,j)*y,t,theta_prev(j));
    theta_new(j)=temp.y(end);
    end
end

%add sgn
%ode45(@(t,y) -2*y+6,t,y0)
