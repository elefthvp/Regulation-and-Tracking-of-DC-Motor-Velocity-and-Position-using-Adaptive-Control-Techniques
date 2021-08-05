function y1 = findw1(F,g,w1_prev,up,instant,M0_w) %,M0_w,q0,sigma0
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
  %sigma_s=switching_modification(w1_prev,M0_w,q0,sigma0);
  if((w1_prev<M0_w) || (w1_prev==M0_w && F*w1_prev+g*up<0))
  y1 = ode45(@diff_eq1,instant,w1_prev);
  function y1 = diff_eq1(t,w1)    
  y1 = F*w1+g*up %-F*sigma_s*w1;
  end
  else
      return;
  end
end

