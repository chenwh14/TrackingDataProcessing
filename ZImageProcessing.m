%%
pathName=uigetdir('C:\','选择包含Z轴图像的文件夹');
dirImages=dir(fullfile(pathName,'*.jpg'));
imageNumber=size(dirImages,1);
interImageDistanceList=zeros(imageNumber,1);
%%
frame=imread(fullfile(pathName,'0.jpg'));
frameWidth=size(frame,2);
frameHeight=size(frame,1);
imageDiameter=frameHeight;
templateHeight=floor(imageDiameter*0.707);
templateWidth=floor(imageDiameter*0.707);
imageInterval=824;
rightImageStart=frameWidth/2+imageInterval-imageDiameter/2+1;
leftImageStart=frameWidth/2-imageInterval-imageDiameter/2+1;
mask=zeros(templateWidth,'uint8');
for i=1:templateWidth
    for j=1:templateWidth
        if ((i-(templateWidth+1)/2)^2+(j-(templateWidth+1)/2)^2<templateWidth^2/4)
            mask(i,j)=1;
        end
    end
end

%%
for i=1:1:imageNumber-1
    frame=imread(fullfile(pathName,[num2str(i),'.jpg']));
    %imshow(frame);

    template=frame(frameHeight/2-templateHeight/2+1:frameHeight/2+templateHeight/2,frameWidth/2-templateWidth/2+1:frameWidth/2+templateWidth/2);
    %figure;
    %imshow(template); 
    leftImage=frame(frameHeight/2-templateHeight/2+1:frameHeight/2+templateHeight/2,leftImageStart:leftImageStart+imageDiameter-1);
    leftResult=matchTemplate(leftImage,template,mask);
    rightImage=frame(frameHeight/2-templateHeight/2+1:frameHeight/2+templateHeight/2,rightImageStart:rightImageStart+imageDiameter-1);
    rightResult=matchTemplate(rightImage,template,mask);
    
    plot([leftResult,rightResult]);
    [~,index]=sort(leftResult,'descend');
    leftMaxIndex=index(1);
    [~,index]=sort(rightResult,'descend');
    rightMaxIndex=index(1);
    interImageDistance=rightMaxIndex-leftMaxIndex;
    interImageDistanceList(i+1)=interImageDistance;
    axis([-inf inf 0 1]);
    title(['Inter-image distance in ',num2str(i),'th frame is ',num2str(interImageDistance)]);
    pause(0.01);
end
%%
figure;
plot(1*interImageDistanceList);
axis([0 imageNumber -inf inf]);