[filename,pathname]=uigetfile({'*.txt'},'��ѡ�������ļ�');

[~,stageX, stageY, headX, headY, commandX, commandY] = textread(fullfile(pathname,filename), '%d,%f,%f,%f,%f,%f,%f');
%%
freq=300;%�ŷ�����Ƶ��
a11=0.0001777326832096361;a12=0.005308842744342313;a21=0.00534395497810797;a22=-0.00019522174569135787;
centerX=208;
centerY=208;
%%
periodBegin=600;periodEnd=6000;
headX=headX(periodBegin:periodEnd,:);
headY=headY(periodBegin:periodEnd,:);
stageX=stageX(periodBegin:periodEnd,:);
stageY=stageY(periodBegin:periodEnd,:);
%%
headErrorX=centerX-headX;headErrorY=centerY-headY;
stageErrorX=headErrorX * a11 + a12 * headErrorY;
stageErrorY=headErrorX * a21 + a22 * headErrorY;
stageTargetX=stageX+stageErrorX;
stageTargetY=stageY+stageErrorY;
headSpeedX=diff(stageTargetX)*300;
headSpeedY=diff(stageTargetY)*300;
%%
figure;
subplot(2,2,1);
distance=sqrt((headX-centerX).^2+(headY-centerY).^2);
[sX,index] = sort(distance,'descend') ;
scatter(headX(index(floor(size(distance)/10):end)),headY(index(floor(size(distance)/10):end)));%���ƾ�����90%�������ڵ�ɢ��ͼ
axis equal;
title('90%ͷ���������ڷ�Χ');
%%
subplot(2,2,2)
plot((1:size(distance))./freq,distance);%������ʱ��仯
title('ͷ��������ͼ�����ľ�����ʱ��仯')
%%
subplot(2,2,3);
plot((1:size(headX))./freq,headX);%ͷ��X������ʱ��仯
hold on;
plot((1:size(headX))./freq,centerX*ones(size(headX)));%Ŀ����
title('ͷ��X������ʱ��仯');
%%
subplot(2,2,4)
plot((1:size(headY))./freq,headY);%ͷ��Y������ʱ��仯
hold on;
plot((1:size(headY))./freq,centerY*ones(size(headY)));%Ŀ����
title('ͷ��Y������ʱ��仯');