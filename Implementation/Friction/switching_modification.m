function sigma_s = switching_modification(theta,M0,q0,sigma0)
%enrich the parameter estimation function with M0,q0,sigma0
% theta is the previous value of the parameter about to undergo switching
% modification 
%calculate sigma_s in the parameter estimation function calling this
%function and subtract sigma_s*gamma*theta at the differential equation
%solution stage 

theta=abs(theta);
if(theta <= M0)
    sigma_s=0;
elseif (theta<=2*M0)
    sigma_s=((theta/M0)-1)^(q0)*sigma0;
else
    sigma_s=sigma0;
end
end

