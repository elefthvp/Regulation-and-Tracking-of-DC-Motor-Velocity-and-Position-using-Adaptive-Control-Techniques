function vtacho= getVtacho(a,vref_arduino,V7805)
velocity = analogRead(a,3);
vtacho = 2 * (2 * velocity * vref_arduino / 1023 - V7805)
end

