function theta = getTheta(a,vref_arduino)
%read raw data
position = analogRead(a,5);
%calculate theta coltage using the formula:
theta = 3 * vref_arduino * position/1023;
end

