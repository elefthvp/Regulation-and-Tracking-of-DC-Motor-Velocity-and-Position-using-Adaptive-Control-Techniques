function relative_displacement(a,displacement,direction)
if(strcmp(direction,'right'))
    analogWrite(a,6,30)
    dt=(90/360)*displacement/3.15  %3.15 einai i taxytita se rpm pou antistoixei sto na grapsw tin timi 30
    pause(dt)
    analogWrite(a,6,0)
elseif(strcmp(direction,'left'))
    analogWrite(a,9,30)
    dt=(90/360)*(displacement-25)/3.15
    pause(dt)
    analogWrite(a,9,0)
    
else
    disp('Invalid Input')
end
end
