function u_vel = RPM2u_vel(kmu,kT,km,RPM)
%kmu = 1/36
%kT = 0.0037
%km = 236.68
w_in = RPM/kmu;
vtacho=kT*w_in; %=vtacho %mexri edw mporw na to xrisimopoihsw gia na ypologisw tin vref me vasi ta epithimita RPM
u_vel=vtacho/(km*kT) %100 is a designer parameter 
end
% u_vel = (1/kmu)*RPM/(100*km)