function letter=reado(imgin)
global dbo
corr=[];
for n=1:34
    s=corr2(dbo{1,n},imgin);
    corr=[corr s];
end
rg=find(corr==max(abs(corr)));
letter='';
if rg==1
    letter='A';
elseif rg==2
    letter='B';
elseif rg==3
    letter='C';
elseif rg==4
    letter='D';
elseif rg==5
    letter='E';
elseif rg==6
    letter='F';
elseif rg==7
    letter='G';
elseif rg==8
    letter='H';
elseif rg==9
    letter='J';
elseif rg==10
    letter='K';
elseif rg==11
    letter='L';
elseif rg==12
    letter='M';
elseif rg==13
    letter='N';
elseif rg==14
    letter='P';
elseif rg==15
    letter='Q';
elseif rg==16
    letter='R';
elseif rg==17
    letter='S';
elseif rg==18
    letter='T';
elseif rg==19
    letter='U';
elseif rg==20
    letter='V';
elseif rg==21
    letter='W';
elseif rg==22
    letter='X';
elseif rg==23
    letter='Y';
elseif rg==24
    letter='Z';
elseif rg==25
    letter='1';
elseif rg==26
    letter='2';
elseif rg==27
    letter='3';
elseif rg==28
    letter='4';
elseif rg==29
    letter='5';
elseif rg==30
    letter='6';
elseif rg==31
    letter='7';
elseif rg==32
    letter='8';
elseif rg==33
    letter='9';
elseif rg==34
    letter='0';
elseif rg==35
    letter='-';
end
