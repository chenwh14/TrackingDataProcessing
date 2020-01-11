[filename,pathname]=uigetfile({'*.txt'},'请选择数据文件');

[~,stageX, stageY, headX, headY, commandX, commandY] = textread(fullfile(pathname,filename), '%d,%f,%f,%f,%f,%f,%f');
%%
freq=300;%伺服控制频率
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

%%
figure;
subplot(2,2,1);
distance=sqrt((headX-centerX).^2+(headY-centerY).^2);
[sX,index] = sort(distance,'descend') ;
scatter(headX(index(floor(size(distance)/10):end)),headY(index(floor(size(distance)/10):end)));%绘制距离在90%最大距离内的散点图
axis equal;
title('90%头部中心所在范围');
%%
subplot(2,2,2)
plot((1:size(distance))./freq,distance);%距离随时间变化
title('头部中心与图像中心距离随时间变化')
%%
subplot(2,2,3);
plot((1:size(headX))./freq,headX);%头部X坐标随时间变化
hold on;
plot((1:size(headX))./freq,centerX*ones(size(headX)));%目标线
title('头部X坐标随时间变化');
%%
subplot(2,2,4)
plot((1:size(headY))./freq,headY);%头部Y坐标随时间变化
hold on;
plot((1:size(headY))./freq,centerY*ones(size(headY)));%目标线
title('头部Y坐标随时间变化');