function u_vel = RPM2u_vel(kmu,kT,km,RPM)
%kmu = 1/36
%kT = 0.0037
%km = 236.68
w_in = RPM/kmu;
vtacho=kT*w_in; %=vtacho
u_vel=vtacho/(km*kT)
end
