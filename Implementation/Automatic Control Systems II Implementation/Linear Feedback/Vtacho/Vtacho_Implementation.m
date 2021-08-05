clear all
close all

%connect arduino
load system_and_gains.mat %from simulation folder, maybe add full path
interval=0.275;
t_space = 0:interval:25;
r = 5;
r = r *ones(1,length(t_space))

x=zeros(length(t_space),2);
y=zeros;
u=zeros;

for i=1:(length(t_space)-1)
    
    t = t_space(i):interval:t_space(i+1);
    u(i) = -k1*x(i)+kr*r(i); 
   
    input=u(i) * ones(1,length(t));
    
    %write this u on the actual system then read velocity 
    x(i+1) = %read velocity 
    
end

plot(t_space,x)
