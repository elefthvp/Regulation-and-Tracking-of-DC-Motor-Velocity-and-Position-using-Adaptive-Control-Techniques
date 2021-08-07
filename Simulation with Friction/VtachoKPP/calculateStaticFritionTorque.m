function [Ts,move] = calculateStaticFritionTorque(Tm,Cs)
if(Tm<Cs)
    Ts=Tm
    move=0;
else
    Ts=Cs %mia monimi afairesi
    move=1;
end
end