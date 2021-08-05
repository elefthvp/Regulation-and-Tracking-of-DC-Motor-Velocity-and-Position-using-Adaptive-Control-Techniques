
%% TO DO: create 2 functions that calculate open loop tf from closed loop and vice versa
%%
numerator = 1;
denominator = [2,3,4];
W_model = tf(numerator,denominator);
t_space=[0:0.01:30];
r=1;
u_r=r*ones(1,length(t_space));
ym= lsim(W_model,u_r,t_space);
%get open loop
A = W_model/(1- W_model)
 A = tf(1,[1,25,150]);
h = rlocusplot(A);
datam = stepinfo(ym,t_space)
figure()
plot(t_space,ym)

m=10;
p = 12;
newzero = tf([1,m],1);
newpole = tf(1,[1,p]);
Anew = A*newzero*newpole;
h2=rlocusplot(Anew)
k =1.43*10^3;
Anew = k* Anew;
Hc = Anew/(1+Anew);


ym= lsim(Hc,u_r,t_space);
datam = stepinfo(ym,t_space)
% figure()
% plot(t_space,ym)
save('Improved','Hc')