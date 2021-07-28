function figures()
%% Figures() 
%This function loads the whole workspace of the main script that calls it and plots all loop signals 
%and variables to make sure they're bounded.
%%
%load workspace.mat
figure(1)
plot(t_space,xm);
hold on
plot(t_space,x);
legend('xm','xp'); 
title('x desired and x plant');
hold off

datap = stepinfo(x,t_space)
datam = stepinfo(xm,t_space)

figure(2)
plot(t_space,e)
title('e')

erelative=(e./xm')*100
figure()
plot(t_space,erelative)
title('erelative')
ylim([-20 20])

disp('maximum erelative is : ')
disp(max(erelative))

disp('minimum erelative is : ')
disp(min(erelative))

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

bla=abs(erelative(end-5000:end));
disp(mean(bla))

user_entry = input('Insert folder name', 's')
save_figures(user_entry,'test_')
prev = pwd;
cd (user_entry);
bhat = b_hat(1)
save('tuning_vars','gamma1','gamma2','M0','q0','sigma0','b0','bhat','interval')
save('results','erelative','x','xm')
cd(prev)
end
