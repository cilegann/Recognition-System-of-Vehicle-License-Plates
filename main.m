function [origimg,plateout,result] = main(input)
  origimgin=imread(input);
  [height,width]=size(origimgin);
  resizee=floor(width*800/height/3);
  origimg  = imresize(origimgin, [800 resizee]);

  [result,plateout,rs,cs,h,w]=locate(origimg,1);
  
   if result=='x'
    [result,plateout,rs,cs,h,w]=locate(origimg,2);
  end

  if result=='x'
    [result,plateout,rs,cs,h,w]=locate_rotate(origimg,1);
  end
 
  if result=='x'
    [result,plateout,rs,cs,h,w]=locate_rotate(origimg,2);
  end
  if rs==0
      result='ERR';plateout=imread('error.png');
  else
    origimg=drawRectangleOnImg(cs,rs,w,h,origimg);
  end
end

function rgbI = drawRectangleOnImg (y,x,h,w,rgbI)
for i=5:8
    rgbI(x-8:x+w+8,y-i,1)   = 255;
    rgbI(x-8:x+w+8,y+h+i,1) = 255;
    rgbI(x-i,y-4:y+h+4,1)   = 255;
    rgbI(x+w+i,y-4:y+h+4,1) = 255;
    rgbI(x-4:x+w+4,y-i,2)   = 0;
    rgbI(x-4:x+w+4,y+h+i,2) = 0;
    rgbI(x-i,y-4:y+h+4,2)   = 0;
    rgbI(x+w+i,y-4:y+h+4,2) = 0;
    rgbI(x-4:x+w+4,y-i,3)   = 0;
    rgbI(x-4:x+w+4,y+h+i,3) = 0;
    rgbI(x-i,y-4:y+h+4,3)   = 0;
    rgbI(x+w+i,y-4:y+h+4,3) = 0;
end
end
