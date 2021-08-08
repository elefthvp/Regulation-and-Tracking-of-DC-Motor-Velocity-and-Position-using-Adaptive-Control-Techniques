function [uint uintwritten] = writeU(a,vref_arduino,u_calculated)
%if u<0, we write on 6 while also making sure that 9 is zero so that it
%actually rotates
if(u_calculated<0)
    u_calculated = -u_calculated;
    analogWrite(a,9,0)
    u_calculated = u_calculated/2*(255/vref_arduino); 
    uint = int16(u_calculated);
    uintwritten=min(uint,255);
    analogWrite(a,6,uintwritten)
else
    %if u>0, we write on 9 while also making sure that 0 is zero so that it
    %actually rotates
    analogWrite(a,6,0)
    u_calculated = u_calculated/2*(255/vref_arduino); 
    uint = int16(u_calculated);
    uintwritten=min(uint,255);
    analogWrite(a,9,uintwritten)
end
end