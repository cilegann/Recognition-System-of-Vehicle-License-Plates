function word=readnumber(input)
img=input;
if input==0
    word='ERROR';
else
txt=fopen('result.txt','wt');
threshold = graythresh(img);
bwimg_uncrop=~im2bw(img);
[height,width]=size(bwimg_uncrop);
bwimg=crop(bwimg_uncrop);
[height,width]=size(bwimg);

dotsize=floor(height*width*0.0003);
bwimg=bwareaopen(bwimg,dotsize);

[L nw]=bwlabel(bwimg);
for i=1:nw
     [r,c]=find(L==i);
     if (((max(c)-min(c))<width*0.044) && ((min(c)>width*0.92 || min(c)<width*0.2)))
         bwimg(min(r):max(r),min(c):max(c))=0;
     end
end


[L nw]=bwlabel(bwimg);
for i=1:nw
  [r,c]=find(L==i);
  if ((max(r)-min(r))/(max(c)-min(c)))<1.5
    w=bwimg(min(r):max(r),min(c):max(c));
    if (sum(sum(w))<(max(r)-min(r))*(max(r)-min(r))*0.8)
        [oh,ow]=size(w);
        %wnew=rotate(w);
        wnew=w;
        wnew(:,floor(ow/2))=0;
        bwimg(min(r):max(r),min(c):max(c))=imresize(wnew,[oh,ow]);
        %bwimg_temp=bwimg;
        %bwimg=0;
        %bwimg(1:min(r),1:min(c))=bwimg_temp(1:min(r),1:min(c));
        %bwimg(min(r)+1:min(r)+1+wh,min(c)+1:min(c)+1+ww)=wnew;
        %bwimg(min(r)+1+wh:height+oh-wh,min(c)+1+ww:width+oh-wh)=bwimg_temp(,);
        %w1=w(:,1:floor(ww/2));
        %w2=w(:,floor(ww/2):ww);
        %ww1=imresize(w1,[42,23]);
        %ww2=imresize(w2,[42,23]);
    end
  end
end

[L nw]=bwlabel(bwimg);

word=[];
load dbn;
load dbo;
global dbn
global dbo
if nw==6
    for i=1:6
        [r,c]=find(L==i);
        w=bwimg(min(r):max(r),min(c):max(c));
        l='';
        if ((max(r)-min(r))/(max(c)-min(c)))>4.7
            l='1';
            word=[word l];
        elseif ((max(r)-min(r))/(max(c)-min(c)))<1.5
            if (sum(sum(w))>(max(r)-min(r))*(max(r)-min(r))*0.7)
            l='-';
            word=[word l];
            else
                wnew=rotate(w);
                [wh,ww]=size(w);
                w1=w(:,1:floor(ww/2));
                w2=w(:,floor(ww/2):ww);
                ww1=imresize(w1,[42,23]);
                ww2=imresize(w2,[42,23]);
                l=reado(ww1);
                word=[word l];
                l=reado(ww2);
                word=[word l];
            end
        else
            w=imresize(w,[42,23]);
            l=reado(w);
            word=[word l];
        end


    end
elseif nw==7
    for i=1:7
        [r,c]=find(L==i);
        w=bwimg(min(r):max(r),min(c):max(c));
        l='';
        if ((max(r)-min(r))/(max(c)-min(c)))>4
            l='1';
        elseif ((max(r)-min(r))/(max(c)-min(c)))<1.5
            l='-';
        else
            w=imresize(w,[42,23]);
            l=reado(w);
        end
    word=[word l];
    end
elseif nw==8
    for i=1:8
        [r,c]=find(L==i);
        w=bwimg(min(r):max(r),min(c):max(c));
        l='';
        if ((max(r)-min(r))/(max(c)-min(c)))>4.7
            l='1';
        elseif ((max(r)-min(r))/(max(c)-min(c)))<=1.5
            l='-';
        else
            w=imresize(w,[126,63]);
            l=readn(w);
        end
        word=[word l];
    end
end

fprintf(txt,'%s\n',word);
fclose(txt);

if size(word)==0
    word='x';
end
end
function final=rotate(todo)
  [h,w]=size(todo);
  state=0;
  low=h;
  while state==0
      if todo(low,1)==0
          low=low-1;
      else
        state=1;
      end
  end
  high=floor(low/2);
  right=1;
  state=0;
  while state==0
      if todo(high,right)==0
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
%{
if size(word)==0
    img=input;
    txt=fopen('result.txt','wt');
    threshold = graythresh(img);
    bwimg_uncrop=im2bw(img,threshold);
    [height,width]=size(bwimg_uncrop);

    dotsize=floor(height*width*0.05);
    bwimg_uncrop=bwareaopen(bwimg_uncrop,dotsize);

    %call crop to crop
    bwimg=crop(bwimg_uncrop);

    %read num of letter

    [L nw]=bwlabel(bwimg);
    word=[];
    if nw==7
        for i=1:7
            [r,c]=find(L==i);
            w=bwimg(min(r):max(r),min(c):max(c));
            if ((max(r)-min(r))/(max(c)-min(c)))>4.7
                l='1';
            elseif ((max(r)-min(r))/(max(c)-min(c)))<1.5
                l='-';
            else
                w=imresize(w,[42,23]);
                l=reado(w);
            end
            word=[word l];
        end
    end
    if nw==8
        for i=1:8
            [r,c]=find(L==i);
            w=bwimg(min(r):max(r),min(c):max(c));
            if ((max(r)-min(r))/(max(c)-min(c)))>4.7
                l='1';
            elseif ((max(r)-min(r))/(max(c)-min(c)))<1.5
                l='-';
            else
                w=imresize(w,[126,63]);
                l=readn(w);
            end
            word=[word l];
        end
    end
    fprintf(txt,'%s\n',word);
    fclose(txt);
end
%}

%close txt
%clear
