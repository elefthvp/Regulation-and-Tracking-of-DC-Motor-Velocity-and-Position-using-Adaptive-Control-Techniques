function u_vel = RPM2u_vel(kmu,kT,km,RPM)
w_in = RPM/kmu;
vtacho=kT*w_in; %=vtacho %mexri edw mporw na to xrisimopoihsw gia na ypologisw tin vref me vasi ta epithimita RPM
u_vel=vtacho/(100*km*kT) %100 is a designer parameter 
end
% u_vel = (1/kmu)*RPM/(100*km)