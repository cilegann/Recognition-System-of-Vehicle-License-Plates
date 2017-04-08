function imgout=crop(imginn)
    [r c]=find(imginn);
    img=imginn(min(r):max(r),min(c):max(c));
    [height,width]=size(img);
    controlhigh=floor(height/2);
    controllow=floor(height/2);
    state=1;
    while state==1
      exactpixel=sum(img(controlhigh,:));
        if exactpixel<(width*0.15) || controlhigh==height
          state=0;
        else
          controlhigh=controlhigh+1;
        end
    end
    state=1;
    while state==1
      exactpixel=sum(img(controllow,:));
        if exactpixel<(width*0.15) || controllow==1
          state=0;
        else
          controllow=controllow-1;
        end
    end
    imgout=img(controllow:controlhigh,:);
end
