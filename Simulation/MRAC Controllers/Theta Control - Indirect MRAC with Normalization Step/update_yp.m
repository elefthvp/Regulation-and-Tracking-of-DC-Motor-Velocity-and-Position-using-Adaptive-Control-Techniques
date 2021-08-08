function y_new = update_yp(u,instant,y_prev,Tm,a)
% state space system simulation by solving a differential equation 
 y_new = ode45(@diff_eq,instant,y_prev);
 function dy = diff_eq(t,y)    
 dy = zeros(2,1);
 dy(1) = y(2);
 dy(2) = (-y(2)+a*u)/Tm;
 end
 end
