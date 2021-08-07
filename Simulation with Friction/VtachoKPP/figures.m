function figures()
%% Figures() 
%This function loads the whole workspace of the main script that calls it and plots all loop signals 
%and variables to make sure they're bounded.
%%
load workspace.mat

figure(1)
plot(t_space,xm);
title('desired trajectory');
hold on
plot(t_space,x)
legend('x desired','x trajectory'); 
hold off

figure(2)
plot(t_space,e)
title('e')

figure(3)
erelative=(abs(e)./xm')*100;
plot(t_space,erelative);
title('relative error')

figure(4)
plot(t_space(1:end-1),u)
title('u')


end
