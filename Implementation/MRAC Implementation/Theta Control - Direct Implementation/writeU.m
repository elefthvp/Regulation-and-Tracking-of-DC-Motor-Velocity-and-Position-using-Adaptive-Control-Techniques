function [uint uintwritten] = writeU(a,vref_arduino,u_calculated)
calib=30;
if(abs(u_calculated)<18)
    calib=6;
elseif(abs(u_calculated)<4)
    calib=2;
end
if(u_calculated<0)
    u_calculated = -u_calculated;
    analogWrite(a,9,0)
    u_calculated = u_calculated/calib*(255/vref_arduino); %probably change mapping function
    uint = int16(u_calculated);
    uintwritten=min(uint,255);
    analogWrite(a,6,uintwritten)
else
    analogWrite(a,6,0)
    u_calculated = u_calculated/calib*(255/vref_arduino); %probably change mapping function
    uint = int16(u_calculated);
    uintwritten=min(uint,255);
    analogWrite(a,9,uintwritten)
end
end