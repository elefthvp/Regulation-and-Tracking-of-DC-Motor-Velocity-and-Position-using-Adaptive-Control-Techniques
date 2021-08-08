function degrees = raw_pos2degrees(read_value,sample)
    load positions.mat
    % marginal conditions need to be taken into consideration
    % 0 degrees = 360 degrees, do not take it into consideration twice!
    deg=[175:sample:360 sample:sample:170] %xanei kapoies times an to sample den einai 5
    %for i=1:length(positions)
    for i=1:length(positions)
    if(read_value >= positions(i) && read_value <= positions(i+1))
        bottom=i;
        top=i+1;
        break;
    end
    end
    degrees = deg(bottom) + ((read_value - positions(bottom)) / (positions(top)- positions(bottom))) * (deg(top) - deg(bottom));
end