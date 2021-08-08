function y = update_rho(instant,gamma,epsilon,xi,rho_prev)
%rho calculation for every instant
  y = ode45(@diff_eq,instant,rho_prev);
  function y = diff_eq(t,rho)    
  y = gamma*epsilon*xi;
  end
end

