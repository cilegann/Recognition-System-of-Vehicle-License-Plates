function [result,plate,rs,cs,h,w]=locate(input,set)
%% prepare data
origimg=input;
%origimgin=imread(input);
%[height,width]=size(origimgin);
 % resizee=floor(width*800/height/3);
%  origimg  = imresize(origimgin, [800 resizee]);
[height,width]=size(origimg);
bw=zeros(height,width/3);
pixel=height*width/3;
%{
%% image pre-process
r_row = sort(reshape(origimg(:,:,1),[pixel,1]));
g_row = sort(reshape(origimg(:,:,2),[pixel,1]));
b_row = sort(reshape(origimg(:,:,3),[pixel,1]));
r_topmark=(sum(r_row(floor(pixel*0.75):pixel))/(pixel-floor(pixel*0.75)))/255;
g_topmark=(sum(g_row(floor(pixel*0.75):pixel))/(pixel-floor(pixel*0.75)))/255;
b_topmark=(sum(b_row(floor(pixel*0.75):pixel))/(pixel-floor(pixel*0.75)))/255;
img = imadjust(origimg,[.3 .3 .3; r_topmark g_topmark b_topmark],[]);
%}

img = imadjust(origimg,[.3 .3 .3; 1 1 1],[]);


%threshold=graythresh(img);
    bw=im2bw(img);


% undot
undot=ceil(pixel*0.00001);
newbw=bwareaopen(~bw,undot);
newbw=~newbw;
%newbw=bw;
% label
[bw_cont,num_cont]=bwlabel(newbw);

for i=1:num_cont
    [r,c]=find(bw_cont==i);
    xr=max(r);
    nr=min(r);
    xc=max(c);
    nc=min(c);
    htemp=xr-nr;
    wtemp=xc-nc;
    ratio=wtemp/htemp;
    if ratio>1.5 && ratio<4
        temp=newbw(nr:xr,nc:xc);
        turn = countturn(temp);
        if turn>10 && turn<=25
            %platebw=newbw(min(r):max(r),min(c):max(c));
            %platepre=origimg(min(r):max(r),min(c):max(c));
            %plate=rotate(platebw,platepre);
            platte=origimg(nr:xr,nc:xc,:);
            result_temp=readnumber(platte);
            if result_temp~=('x')
                rs=nr;
                cs=nc;
                h=htemp;
                w=wtemp;
                result=result_temp;
                plate=platte;
                break;
            end
        end
    end
end

if exist('plate','var')==0
    plate=0;
    rs=0;
    cs=0;
    h=0;
    w=0;
    result='x';
end









function turn=countturn(imgin)
imgin=~imgin;
[h,w]=size(imgin);
high=ceil(h*0.55);
low=ceil(h*0.45);
turn=0;
b=zeros(1,w);
for i=1:w
    if sum(imgin(low:high,i))==0
        b(i)=0;
    else
        b(i)=1;
    end
end

for i=1:w-1
    if (b(i)~=b(i+1))
        turn=turn+1;
    end
end

function final=rotate(ref,todo)
  [h,w]=size(ref);
  state=0;
  low=h;
  while state==0
      if ref(low,1)==0
          low=low-1;
      else
        state=1;
      end
  end
  high=floor(low/2);
  right=1;
  state=0;
  while state==0
      if ref(high,right)==0
          right=right+1;
      else
        state=1;
      end
  end
  angle=radtodeg(atan(right/high));
  if angle>1
      if angle<45
          afterrotate=imrotate(todo,angle);
          cut=low*sin(angle*pi/180);
      else
          afterrotate=imrotate(todo,angle-45);
          cut=(h-low)*sin((angle-45)*pi/180);
      end
        [ah,aw]=size(afterrotate);
        addcut=aw*0.025;
        final=afterrotate(:,cut+addcut:aw-cut-addcut);
  else
      final=todo;
  end
