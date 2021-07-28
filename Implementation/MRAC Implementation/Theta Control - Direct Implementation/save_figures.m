function save_figures(fname,reference)
figHandles = findall(0,'Type','figure');
% mkdir (fname);
% % cd
% prev = pwd;
% cd (fname);
%change code so it is create once 
if not(isfolder(fname))
    mkdir(fname);
end

prev = pwd;
cd (fname);

% saveas(figHandles,[reference,'.png']);
for i = 1:numel(figHandles)
%      export_fig(fn, '-jpg', figHandles(i),'-append')
     saveas(figHandles(i),[reference,(num2str(i)),'.png']);
     
end
cd(prev)
end

