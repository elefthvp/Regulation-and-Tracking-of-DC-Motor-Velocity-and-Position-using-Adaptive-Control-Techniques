function [pc_velocity,multimeter_velocity,velocity,RPMfromFunction] = vel_voltage_measurements(a,sampling,vref_arduino,V7805)

pc_velocity=zeros;
multimeter_velocity = zeros;
velocity = zeros;
RPMfromFunction = zeros;

n=sampling:sampling:255;

for i = 1:length(n)
   analogWrite(a,6,n(i))
   disp(n(i))
   velocity(i) = analogRead(a,3)
   pc_velocity(i)= 2 * (2 * velocity(i) * vref_arduino / 1023 - V7805)
   disp(['pc_velocity ' pc_velocity(i)])
   
   RPMfromFunction(i)= vel_voltage2RPM(1/36,0.0037,pc_velocity(i))
   
   
   user_entry = input('Measure voltage manually, then input ', 's')
   multimeter_velocity(i) = str2num(user_entry);
end
end