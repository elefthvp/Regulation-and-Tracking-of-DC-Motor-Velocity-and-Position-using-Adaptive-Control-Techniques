function figures()
%% Figures() 
%This function loads the whole workspace of the main script that calls it and plots all loop signals 
%and variables to make sure they're bounded.
%%
load workspace.mat
figure(1)
plot(t_space,xm);
hold on
plot(t_space,x);
legend('xm','xp'); 
title('x desired and x plant');
hold off

figure(2)
plot(t_space,e)
title('e')

figure(3)
plot(t_space,a_hat)
title('ahat')

figure(4)
plot(t_space,b_hat)
title('bhat')

figure(5)
plot(t_space(1:end-1),k)
title('k')

figure(6)
plot(t_space(1:end-1),l)
title('l')


figure(7)
plot(t_space(1:end-1),u)
title('u')
end
