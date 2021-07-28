function figures()
%% Figures() 
%This function loads the whole workspace of the main script that calls it and plots all loop signals 
%and variables to make sure they're bounded.
%%
load workspace.mat

figure(3)
plot(t_space,w1w2(:,1))
% title('w1')
hold on

plot(t_space,w1w2(:,2))
title('w1 and w2')
hold off


figure(1)
plot(t_space,ym(1:length(t_space)))
hold on
plot(t_space,yp)
legend('ym','yp')
title('ym and yp')
hold off
t_space=t_space(1:length(yp)) %if simulation was forced to stop before
% completion

figure(2)
plot(t_space(1:length(epsilon)),e1)
title('e1')
hold on
plot(t_space(1:length(epsilon)),epsilon)
title('e1 and epsilon')
legend('e1','epsilon')
hold off




figure(4)

hold on 
plot(t_space(1:length(up)),up)
plot(t_space(1:length(uf)),uf)
title('up and uf')
legend('up','uf')
hold off

figure(5)
plot(t_space,theta(:,1:4))
title('Theta Vector')
legend('theta1','theta2','theta3','theta4')
%(1:length(up))
figure(6)
plot(t_space,xi)
title('xi')

figure(7)
plot(t_space,ms_squared)
title('ms^2')

figure()
plot(uwritten)
hold on
% figure()
plot(up)
legend('uwritten','up')


user_entry = input('Insert folder name', 's')
save_figures(user_entry,'test_')
prev = pwd;
cd (user_entry);
calib=[30 6 2]
save('tuning_vars','gamma','M0','q0','sigma0','interval','calib')
save('results','ym','yp','up')
cd(prev)

end

