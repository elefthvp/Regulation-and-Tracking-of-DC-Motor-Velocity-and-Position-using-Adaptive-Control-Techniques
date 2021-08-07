function y= integrate_first_order(a,b,u,t,y_prev,J,R,Co,Cs,vtacho_p,vtacho_pp,dt,kmu,kT)
persistent acc
persistent s_torque
acc=(-a*y_prev+b*u-s_torque)/kT %acceleration gets too big even without the s_toque term

if(y_prev/kT<0.1)
s_torque = calculateStaticFritionTorque(J,R,Co,Cs,y_prev,vtacho_p,vtacho_pp,dt,kmu,kT,u,acc);
else
    s_torque=0;
end

temp = ode45(@(t,x)-a*x+b*u-s_torque,t,y_prev);
y=temp.y
% y_new=temp.y(end);

end
