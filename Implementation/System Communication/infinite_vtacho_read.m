vtacho=zeros;
i=1;
while(1)
velocity = analogRead(ard,3);
vtacho(i) = 2 * (2 * velocity * vref_arduino / 1023 - V7805)
i=i+1;
end

