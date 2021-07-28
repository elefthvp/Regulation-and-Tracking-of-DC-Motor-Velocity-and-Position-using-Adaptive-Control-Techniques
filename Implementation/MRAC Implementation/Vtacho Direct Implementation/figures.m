function figures()
%% Figures() 
%This function loads the whole workspace of the main script that calls it and plots all loop signals 
%and variables to make sure they're bounded.
%%
load workspace.mat
% motorPowerOff(ard)

figure(1)
plot(t_space,xm);
title('2+sin(1.5*t_space)');
hold on
plot(t_space,x)
legend('x desired','x trajectory'); 
hold off


figure(2)
plot(t_space,e)
title('e')

erelative=(e./xm')*100

% figure()
% plot(t_space,erelative)
% title('erelative')

figure(3)
plot(t_space,k_l(:,1))
title('k')
% 
% 
figure(4)
plot(t_space,k_l(:,2))
title('l')


figure(5)
plot(t_space(1:end-1),u)
title('u')

save_figures('test11','test11')
end
