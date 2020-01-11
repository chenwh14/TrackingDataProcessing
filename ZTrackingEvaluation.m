[filename,pathname]=uigetfile({'*.txt'},'请选择Z轴跟踪数据文件');

[stagePosition,interImageDistance,command] = textread(fullfile(pathname,filename), '%f,%f,%f');
time=0:0.011:size(interImageDistance)*0.011-0.011;
%%
subplot(2,2,1);
plot(time,interImageDistance);
title('像间距');
subplot(2,2,2);
plot(time,stagePosition);
title('平台位置');
subplot(2,2,3);
plot(time,command);
title('目标位置');