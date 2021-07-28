function theta = getTheta(a,vref_arduino)
position = analogRead(a,5);
theta = 3 * vref_arduino * position/1023;
end

