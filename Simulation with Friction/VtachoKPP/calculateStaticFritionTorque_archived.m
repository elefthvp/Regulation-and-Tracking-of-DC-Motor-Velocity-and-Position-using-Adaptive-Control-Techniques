function Ts = calculateStaticFritionTorque(J,R,Co,Cs,vtacho,vtacho_p,vtacho_pp,dt,kmu,kT,u,dw)
% Ts will be taken into consideration when velocity drops beneath a certain
% level (level = designer parameter)
% Cs>Co
%R=5.35
%J = 0.00000275
Tm = (u-vtacho)/R
% wp = vtacho_p/kT %edw mallon xreiazomai ton kinitira eisodou
% wpp = vtacho_pp/kT %*kmu
% dw=(wp-wpp)/dt
%change ==0 to a certain level, another designer parameter 
if(dw==0)
    if(abs(Tm)<Cs) 
        Ts = Tm;
    else
        Ts = Co*sign(Tm);
    end
    
else
    if(abs(Tm-J*dw)<Co)
        Ts = Tm;
    else
        Ts = Co*sign(vtacho);
    end
    
end
end

