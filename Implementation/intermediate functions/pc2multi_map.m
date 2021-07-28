function [mappedvoltage,mappederror] = pc2multi_map(read_value)
%function that gets the transformed voltage of position as measured with a
%pc and maps it to the respective multimeter voltage using linear
%interpolation
%tha doulepsw me tis taseis pou metraw apo tin plaketa wste na vlepw ston
%palmografo apotelesma pou tairiazei me ayto pou thelw kai den einai o,ti
%na nai
%there are marginal conditions to be taken into consideration.
load multimeter_voltage.mat
load pc_voltage.mat
%pws vriskw ti ginetai otan eimai sta midenika?
error = pc_voltage-multimeter_voltage
for i=1:length(pc_voltage)
    if(read_value >= pc_voltage(i) && read_value <= pc_voltage(i+1))
        bottom=i;
        top=i+1;((read_value - pc_voltage(bottom)) / (pc_voltage(top)- pc_voltage(bottom))) * (error(top) - error(bottom))
        break;
    end
end
%error(bottom)
mappederror= error(bottom)+abs(((read_value - pc_voltage(bottom)) / (pc_voltage(top)- pc_voltage(bottom)))) * (error(top) - error(bottom))
mappedvoltage = read_value-mappederror
end
%mallon den yparxei kapoio provlima stin ylopoihsh alla yparxei problima
%stin orthotita tis xrisis tis grammikis parembolis stin prokeimeni
%periptwsi.

