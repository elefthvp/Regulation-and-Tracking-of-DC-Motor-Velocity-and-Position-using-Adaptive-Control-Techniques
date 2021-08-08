function y1 = findw1(F,g,w1_prev,up,instant)
%w1 differential equation calculation
  y1 = ode45(@diff_eq1,instant,w1_prev);
  function y1 = diff_eq1(t,w1)    
  y1 = F*w1+g*up;
  end


  
end

