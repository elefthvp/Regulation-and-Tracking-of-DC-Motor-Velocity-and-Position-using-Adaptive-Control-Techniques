function  absolute_displacement(a,desired_position)
motorPowerOff(a)
current_position = analogRead(a,5);
current_position_degrees = raw_pos2degrees(current_position,5)
%sample is always 5

displacement = abs(current_position_degrees-desired_position)
if(desired_position>current_position_degrees)
    relative_displacement(a,displacement,'left')
elseif (desired_position<current_position_degrees)
     relative_displacement(a,displacement,'right')
else
     disp('No displacement needed')
end
end

