%%
clearvars -except ard vref_arduino V7805;

close all

arduino_connected=exist('ard');
if(~arduino_connected)
    ard=arduino('COM3');
end

vref_set = exist('vref_arduino');
if(~vref_set)
    [vref_arduino,V7805] = setVref_V7805(ard);
end