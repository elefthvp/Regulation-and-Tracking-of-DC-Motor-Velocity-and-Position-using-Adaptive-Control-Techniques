function uint = writeU(a,vref_arduino,u_calculated)
if(u_calculated<0)
    u_calculated = -u_calculated;
    analogWrite(a,9,0)
    u_calculated = u_calculated/2*(255/vref_arduino) %probably change mapping function
    uint = int8(u_calculated)
    analogWrite(a,6,min(uint,255))
else
    analogWrite(a,6,0)
    u_calculated = u_calculated/2*(255/vref_arduino) %probably change mapping function
    uint = int8(u_calculated)
    analogWrite(a,9,min(uint,255))
end
end