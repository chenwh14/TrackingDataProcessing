%%
pathname=uigetdir('C:\','选择包含Z轴图像的文件夹');
dirImages=dir(fullfile(pathname,'*.jpg'));
imageNumber=size(dirImages,1);
interImageDistanceList=zeros(imageNumber,1);
%%
for i=0:1:1000
    frame=imread(fullfile(pathname,[num2str(i),'.jpg']));
    %imshow(frame);
    frameWidth=size(frame,2);
    frameHeight=size(frame,1);
    templateHeight=floor(frameHeight*0.707);
    templateWidth=templateHeight;
    template=frame(frameHeight/2-templateHeight/2:frameHeight/2+templateHeight/2-1,frameWidth/2-templateWidth/2:frameWidth/2+templateWidth/2-1);
    %figure;
    %imshow(template);
    vec_sub=double(template(:));
    norm_sub=norm(vec_sub);
    templateMatchResult=zeros(frameWidth-templateWidth+1,1);

    for cursor=1:frameHeight-templateWidth
        subFrame=frame(frameHeight/2-templateHeight/2:frameHeight/2+templateHeight/2-1,cursor:cursor+templateWidth-1);
        vec=double(subFrame(:));
        templateMatchResult(cursor)=vec'*vec_sub / (norm(vec)*norm_sub+eps);
    end
    for cursor=frameWidth-frameHeight+2:frameWidth-templateWidth+1
        subFrame=frame(frameHeight/2-templateHeight/2:frameHeight/2+templateHeight/2-1,cursor:cursor+templateWidth-1);
        vec=double(subFrame(:));
        templateMatchResult(cursor)=vec'*vec_sub / (norm(vec)*norm_sub+eps);
    end
    plot(templateMatchResult);
    [~,index]=sort(templateMatchResult(1:frameHeight-templateWidth),'descend');
    leftMaxIndex=index(1);
    [~,index]=sort(templateMatchResult(frameWidth-frameHeight+2:frameWidth-templateWidth+1),'descend');
    rightMaxIndex=index(1);
    interImageDistance=rightMaxIndex-leftMaxIndex;
    interImageDistanceList(i+1)=interImageDistance;
    title(['Inter-image distance in ',num2str(i),'th frame is ',num2str(interImageDistance)]);
    pause(0.01);
end
%%
figure;
plot(8*interImageDistanceList);
axis([0 1000 -inf inf]);