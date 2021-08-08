%test this
%connect arduino and all
clear all
%add full path to load the matrix
load theta_system_and_gains.mat
interval=0.275;
t_space = 0:interval:25;
r = 5;
r = r *ones(1,length(t_space))

x=zeros(length(t_space),2);
y=zeros;
u=zeros;

%the way this system was created with ss, x2 is theta and x1 is its
%derivative, vtacho.
%the way I do this manually, x1 would have been theta and x2 vtacho.
%Matlab's ss function does this the other way around.

for i=1:(length(t_space)-1)
    
    t = t_space(i):interval:t_space(i+1);
    u(i) = -k1*x(i,1)-k2*x(i,2)+kr*r(i); 
    
    input=u(i) * ones(1,length(t));
    %write u 
    % read x1(i+1) = velocity and x2(i+1) = position and use as (i) in next iteration to calculate u(i). 

    
end

figure()
plot(t_space,y)