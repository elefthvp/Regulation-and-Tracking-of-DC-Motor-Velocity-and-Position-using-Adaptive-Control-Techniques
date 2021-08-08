function vtacho= getVtacho(a,vref_arduino,V7805)
%read raw data
velocity = analogRead(a,3);
%calculate theta coltage using the formula:
vtacho = 2 * (2 * velocity * vref_arduino / 1023 - V7805);
end

