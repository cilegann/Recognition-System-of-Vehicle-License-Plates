function [result,plate,rs,cs,h,w]=locate_rotate(input)
%% prepare data
%origimgin=imread(input);
%[height,width]=size(origimgin);
 % resizee=floor(width*800/height/3);
 % origimg  = imresize(origimgin, [800 resizee]);
origimg=input;
 [height,width]=size(origimg);
bw=zeros(height,width/3);
%%
% 
%   for x = 1:10
%       disp(x)
%   end
% 
pixel=height*width/3;

%% image pre-process
% 
%   for x = 1:10
%       disp(x)
%   end
% 
img = imadjust(origimg,[.3 .3 .3; 1 1 1],[]);
%% use 12.5% as white
r_row = sort(reshape(img(:,:,1),[pixel,1]));
g_row = sort(reshape(img(:,:,2),[pixel,1]));
b_row = sort(reshape(img(:,:,3),[pixel,1]));
%r_topmark=r_row(floor(pixel*0.875));
%g_topmark=g_row(floor(pixel*0.875));
%b_topmark=b_row(floor(pixel*0.875));
r_topmark=sum(r_row(floor(pixel*0.75):pixel))/(pixel-floor(pixel*0.75));
g_topmark=sum(g_row(floor(pixel*0.75):pixel))/(pixel-floor(pixel*0.75));
b_topmark=sum(b_row(floor(pixel*0.75):pixel))/(pixel-floor(pixel*0.75));
%% find white
for i=1:(height)
   for j=1:(width/3)
        check=(img(i,j,1)>r_topmark)+(img(i,j,2)>g_topmark)+(img(i,j,3)>b_topmark);
       if check>1
           bw(i,j)=1;
       end
   end
end
% undot
undot=ceil(pixel*0.0005);
%newbw=bwareaopen(~bw,undot);
%newbw=~newbw;
% label
newbw=bw;
[bw_cont,num_cont]=bwlabel(newbw);
for i=1:num_cont
    [r,c]=find(bw_cont==i);
    ratio=(max(c)-min(c))/(max(r)-min(r));
    if ratio>1.5 && ratio<4
        temp=newbw(min(r):max(r),min(c):max(c));
        turn = countturn(temp);
        if turn>10 && turn<=23
            platebw=newbw(min(r):max(r),min(c):max(c));
            platepre=origimg(min(r):max(r),min(c):max(c));
            platte=rotate(platebw,platepre);
            result_temp=readnumber2(platte);
            if result_temp~='x'
                %plate=origimg(min(r):max(r),min(c):max(c));
                rs=min(r);
                cs=min(c);
                h=max(r)-min(r);
                w=max(c)-min(c);
                result=result_temp;
                plate=platte;
                break;
            end
        end
    end
end

if exist('plate','var')==0
    plate=0;
    result='x';
    rs=0; cs=0; h=0; w=0;
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
  end

