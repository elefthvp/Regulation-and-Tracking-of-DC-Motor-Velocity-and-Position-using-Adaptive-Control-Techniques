a=arduino('COM3');
velocity = analogRead(a,3)
position = analogRead(a,5)
voltage = 9.57 %MEASURE MANUALLY
vref_arduino = voltage*1024/(3*position)
V7805=2 * velocity * vref_arduino / 1023

%get state vector
position = analogRead(a,5)
x1 = 3 * vref_arduino * position/1023; %is this in degrees?
velocity = analogRead(a,3)
x2 = 2 * (2 * velocity * vref_arduino / 1023 - V7805) %velocity = zero
analogWrite(a,9,0)

while(1)plot
    position = analogRead(a,5);
    x1 = 3 * vref_arduino * position/1023
    pause(0.25)
end
u_vel = u_vel/2*(255/vref_arduino) %probably change mapping function
u_vel = int8(u_vel)
analogWrite(a,6,min(u_vel,255))
    