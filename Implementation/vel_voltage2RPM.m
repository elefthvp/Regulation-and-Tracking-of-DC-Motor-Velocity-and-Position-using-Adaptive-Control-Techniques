function RPM = vel_voltage2RPM(kmu,kT,vel_voltage)
w_in = vel_voltage/kT
RPM = w_in/(1/kmu)
end