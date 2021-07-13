function u_vel = RPM2u_vel(kmu,kT,km,RPM)
w_in = RPM/kmu;
vtacho=kT*w_in; %=vtacho
u=vtacho/(km*kT)
end