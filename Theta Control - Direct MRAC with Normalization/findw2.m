function y2 = findw2(F,g,w2_prev,yp,instant)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
  y2 = ode45(@diff_eq2,instant,w2_prev);
  function y2 = diff_eq2(t,w2)    
  y2 = F*w2+g*yp;
  end
 
end

