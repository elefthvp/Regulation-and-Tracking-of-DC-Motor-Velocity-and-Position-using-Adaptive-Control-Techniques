function figures()
%% Figures() 
%This function loads the whole workspace of the main script that calls it and plots all loop signals 
%and variables to make sure they're bounded.
%%
load workspace.mat

figure(1)
plot(t_space,ym)
hold on
plot(t_space,yp)
legend('ym','yp')
title('ym and yp')
hold off

figure(2)
plot(t_space,e1)
title('e1')
hold on
plot(t_space,epsilon)
title('e1 and epsilon')
legend('e1','epsilon')
hold off

figure(3)
plot(t_space,w1w2(:,1))
% title('w1')
hold on

plot(t_space,w1w2(:,2))
title('w1 and w2')
hold off

figure(4)

hold on 
plot(t_space(1:end-1),up)
plot(t_space,uf)
title('up and uf')
legend('up','uf')
hold off

figure(5)
plot(t_space,theta(:,1:4))
title('Theta Vector')
legend('theta1','theta2','theta3','theta4')

figure(6)
plot(t_space,xi)
title('xi')

figure(7)
plot(t_space,ms_squared)
title('ms^2')



end

