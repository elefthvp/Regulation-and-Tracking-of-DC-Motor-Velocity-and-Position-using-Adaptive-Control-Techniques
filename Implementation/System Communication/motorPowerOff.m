function motorPowerOff(a)
%write 0 to both pins to neutralize left or right rotation
analogWrite(a,6,0)
analogWrite(a,9,0)
end
