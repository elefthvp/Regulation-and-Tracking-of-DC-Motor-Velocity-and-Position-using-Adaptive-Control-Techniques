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
plot(t_space(1:length(e1)),e1)
title('e1')


figure(3)
plot(t_space,w1w2(:,1))
% title('w1')
hold on

plot(t_space,w1w2(:,2))
title('w1 and w2')
hold off

disp('Theta* is: ');
disp(double(theta));
end

