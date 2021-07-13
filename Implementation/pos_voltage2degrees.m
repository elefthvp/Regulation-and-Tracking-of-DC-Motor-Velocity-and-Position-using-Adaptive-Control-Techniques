function [pc_voltage,multimeter_voltage,positions] = pos_voltage2degrees(a,sampling,vref_arduino)
%sampling: manual position shift per iteration 

pc_voltage=zeros;
multimeter_voltage = zeros;
positions = zeros;
n=360/sampling;
for i = 1:n
   disp(i)
   positions(i) = analogRead(a,5)
   pc_voltage(i) = 3 * vref_arduino * positions(i)/1023; 
   disp(pc_voltage(i))
   
   user_entry = input('Measure voltage manually, then input ', 's')
   multimeter_voltage(i) = str2num(user_entry);
   pause
end
%after acquiring the data: 
% error = pc_voltage-multimeter_voltage
% mean(error) = 0.0351





end



