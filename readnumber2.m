function word=readnumber(input)
img=input;
if input==0
    word='ERROR';
else
txt=fopen('result.txt','wt');
threshold = graythresh(img);
bwimg_uncrop=~im2bw(img,threshold);
[height,width]=size(bwimg_uncrop);
bwimg=crop(bwimg_uncrop);
[height,width]=size(bwimg);

dotsize=floor(height*width*0.0003);
bwimg=bwareaopen(bwimg,dotsize);
[L nw]=bwlabel(bwimg,4);
for i=1:nw
     [r,c]=find(L==i);
     if (((max(c)-min(c))<width*0.044) && ((min(c)>width*0.92 || min(c)<width*0.2)))
         bwimg(min(r):max(r),min(c):max(c))=0;
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
        elseif ((max(r)-min(r))/(max(c)-min(c)))<1.5
            l='-';
        else
            w=imresize(w,[42,23]);
            l=reado(w);
        end
        
    word=[word l];
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

if size(word)==0
    word='x';
end
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
