function sigma_s = switching_modification(theta,M0,q0,sigma0)
theta=abs(theta);
if(theta <= M0)
    sigma_s=0;
elseif (theta<=2*M0)
    sigma_s=((theta/M0)-1)^(q0)*sigma0;
else
    sigma_s=sigma0;
end
end

