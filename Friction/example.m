function [y,s_torque,Tm] = integrate_first_order(a,b,u,t,y_prev,R,Cs,Cc,kT)

if(abs(y_prev/kT)<50)
s_torque=Cs;
if(~y_prev==0)
s_torque=sign(y_prev)*s_torque
end
else
    s_torque=0;
end

if(abs(y_prev/kT)>0.1)
c_Torque=Cc;
else
    c_Torque=0;
end

temp= ode45(@(t,x)-a*x+b*u-s_torque-c_torque,t,y_prev);
tempy=temp.y;
y=tempy(end);

end