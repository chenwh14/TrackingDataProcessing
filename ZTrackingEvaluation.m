[datafilename,datapathname]=uigetfile({'*.txt'},'��ѡ��Z����������ļ�');

[stagePosition,interImageDistance,command] = textread(fullfile(datapathname,datafilename), '%f,%f,%f');
time=0:0.011:size(interImageDistance)*0.011-0.011;
%%
figure;
subplot(2,2,1);
plot(time,interImageDistance);
title('����');
subplot(2,2,2);
plot(time,stagePosition);
title('ƽ̨λ��');
subplot(2,2,3);
plot(time,command);
title('Ŀ��λ��');