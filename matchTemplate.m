function [result] = matchTemplate(image,template,mask)
%MATCHTEMPLATE ģ��ƥ�亯��
%   �˴���ʾ��ϸ˵��
[templateWidth,templateHeight]=size(template');
[imageWidth,imageHeight]=size(image');
result=zeros(imageHeight-templateHeight+1,imageWidth-templateWidth+1);
vec_temp=double(template(:).*mask(:));
vec_temp=vec_temp-mean(vec_temp);
for cursorX=1:imageWidth-templateWidth+1
    for cursorY=1:imageHeight-templateHeight+1
        subImage=image(cursorY:cursorY+templateHeight-1,cursorX:cursorX+templateWidth-1);
        vec_sub=double(subImage(:).*mask(:));
        vec_sub=vec_sub-mean(vec_sub);
        result(cursorY,cursorX)=vec_temp'*vec_sub/(norm(vec_temp)*norm(vec_sub)+eps);
    end
end
