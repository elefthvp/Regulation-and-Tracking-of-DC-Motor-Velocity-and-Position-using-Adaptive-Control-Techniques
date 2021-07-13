function [pc_voltage,multimeter_voltage] = pos_voltage2degrees(sampling,vref_arduino)
%sampling: manual position shift per iteration 

a=arduino('COM3')
pc_voltage=zeros;
multimeter_voltage = zeros;
positions = zeros;
n=360/sampling;
for i = 1:n
   positions(i) = analogRead(a,5)
   pc_voltage(i) = 3 * vref_arduino * positions(i)/1023; 
   
   user_entry = input('Measure voltage manually, then input ', 's')
   multimeter_voltage(i) = str2num(user_entry);
   
   
end



end


