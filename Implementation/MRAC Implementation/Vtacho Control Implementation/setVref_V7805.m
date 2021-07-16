function [vref_arduino,V7805] = setVref_V7805(a)
%call as setVref_V7805('COMX') where X=arduino port number as shown in the
%Arduino IDE


velocity = analogRead(a,3);
position = analogRead(a,5);

user_entry = input('Measure motor position voltage manually, then input ', 's')
voltage = str2num(user_entry);

%vref_arduino
vref_arduino = voltage*1024/(3*position);
%vref_7805
V7805 = 2 * velocity * vref_arduino / 1023;
end