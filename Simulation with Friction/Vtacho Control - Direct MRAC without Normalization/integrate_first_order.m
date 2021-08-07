function [y,s_torque,Tm] = integrate_first_order(a,b,u,t,y_prev,R,Cs,kT)
Tm = (u-y_prev)/R
% persistent move
if(abs(y_prev/kT)<50)
[s_torque,move]= calculateStaticFritionTorque(Tm,Cs);
if(~y_prev==0)
s_torque=sign(y_prev)*s_torque
end
else
    s_torque=0;
end
% if(move)
temp= ode45(@(t,x)-a*x+b*u-s_torque-10,t,y_prev);
tempy=temp.y
y=tempy(end)
% y_new=temp.y(end);
% else
%     y=y_prev
% end
    

end