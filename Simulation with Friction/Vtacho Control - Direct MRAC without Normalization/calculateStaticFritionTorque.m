function [Ts,move] = calculateStaticFritionTorque(Tm,Cs)
% if(Tm<Cs)
    Ts=Tm
    move=0;
% else
    Ts=20; %mia monimi afairesi
    move=1;
% end
end