function y2 = findw2(F,g,w2_prev,yp,instant,M0_w) %,M0_w,q0,sigma0

  %sigma_s=switching_modification(w2_prev,M0_w,q0,sigma0);

  if((w2_prev<M0_w) || (w2_prev==M0_w && F*w2_prev+g*yp<0))
  y2 = ode45(@diff_eq2,instant,w2_prev);
  function y2 = diff_eq2(t,w2)    
  y2 = F*w2+g*yp %-F*sigma_s*w2;
  end
  else
      return;
  end
 
end

