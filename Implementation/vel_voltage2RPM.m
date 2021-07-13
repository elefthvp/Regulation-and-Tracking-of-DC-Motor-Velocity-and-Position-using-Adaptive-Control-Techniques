function RPM = vel_voltage2RPM(kmu,kT,vel_voltage)
w_in = vel_voltage/kT
RPM = w_in/(1/kmu)
end
%wrote: analogWrite(a,6,30)
%velocity was measured: 536
%x2 = -0.4738
%function returned: -3.5573 RPM
%I measured by observing: 3.0848 RPM and a multimeter voltage of 0.47-0.51 volts