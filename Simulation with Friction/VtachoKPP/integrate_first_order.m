function y= integrate_first_order(a,b,u,t,y_prev,R,Cs,kT)
Tm = (u-y_prev)/R
persistent move
if(y_prev/kT<0.6)
[s_torque,move]= calculateStaticFritionTorque(Tm,Cs);
else
    s_torque=0;
end
% if(move)
[tempx,tempy] = ode45(@(t,x)-a*x+b*u-s_torque,t,y_prev);
y=tempy(end)
% y_new=temp.y(end);
% else
%     y=y_prev
% end
    

end