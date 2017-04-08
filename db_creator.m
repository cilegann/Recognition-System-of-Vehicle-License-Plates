delete ('dbo.mat')
delete ('dbn.mat')
%%%%%%%% OLD LETTER %%%%%%%
oa=~im2bw(imread('database/oa.bmp'));
ob=~im2bw(imread('database/ob.bmp'));
oc=~im2bw(imread('database/oc.bmp'));
od=~im2bw(imread('database/od.bmp'));
oe=~im2bw(imread('database/oe.bmp'));
of=~im2bw(imread('database/of.bmp'));
og=~im2bw(imread('database/og.bmp'));
oh=~im2bw(imread('database/oh.bmp'));
%oi=~im2bw(imread('database/oi.bmp'));
oj=~im2bw(imread('database/oj.bmp'));
ok=~im2bw(imread('database/ok.bmp'));
ol=~im2bw(imread('database/ol.bmp'));
om=~im2bw(imread('database/om.bmp'));
on=~im2bw(imread('database/on.bmp'));
%oo=~im2bw(imread('database/oo.bmp'));
op=~im2bw(imread('database/op.bmp'));
oq=~im2bw(imread('database/oq.bmp'));
or=~im2bw(imread('database/or.bmp'));
os=~im2bw(imread('database/os.bmp'));
ot=~im2bw(imread('database/ot.bmp'));
ou=~im2bw(imread('database/ou.bmp'));
ov=~im2bw(imread('database/ov.bmp'));
ow=~im2bw(imread('database/ow.bmp'));
ox=~im2bw(imread('database/ox.bmp'));
oy=~im2bw(imread('database/oy.bmp'));
oz=~im2bw(imread('database/oz.bmp'));

%%%%%%%% NEW LETTER %%%%%%%
na=~im2bw(imread('database/lna.bmp'));
nb=~im2bw(imread('database/lnb.bmp'));
nc=~im2bw(imread('database/lnc.bmp'));
nd=~im2bw(imread('database/lnd.bmp'));
ne=~im2bw(imread('database/lne.bmp'));
nf=~im2bw(imread('database/lnf.bmp'));
ng=~im2bw(imread('database/lng.bmp'));
nh=~im2bw(imread('database/lnh.bmp'));
%ni=~im2bw(imread('database/lni.bmp'));
nj=~im2bw(imread('database/lnj.bmp'));
nk=~im2bw(imread('database/lnk.bmp'));
nl=~im2bw(imread('database/lnl.bmp'));
nm=~im2bw(imread('database/lnm.bmp'));
nn=~im2bw(imread('database/lnn.bmp'));
%no=~im2bw(imread('database/lno.bmp'));
np=~im2bw(imread('database/lnp.bmp'));
nq=~im2bw(imread('database/lnq.bmp'));
nr=~im2bw(imread('database/lnr.bmp'));
ns=~im2bw(imread('database/lns.bmp'));
nt=~im2bw(imread('database/lnt.bmp'));
nu=~im2bw(imread('database/lnu.bmp'));
nv=~im2bw(imread('database/lnv.bmp'));
nw=~im2bw(imread('database/lnw.bmp'));
nx=~im2bw(imread('database/lnx.bmp'));
ny=~im2bw(imread('database/lny.bmp'));
nz=~im2bw(imread('database/lnz.bmp'));
%%%%%%%% OLD NUM %%%%%%%

o1=~im2bw(imread('database/o1.bmp'));
o2=~im2bw(imread('database/o2.bmp'));
o3=~im2bw(imread('database/o3.bmp'));
o4=~im2bw(imread('database/o4.bmp'));
o5=~im2bw(imread('database/o5.bmp'));
o6=~im2bw(imread('database/o6.bmp'));
o7=~im2bw(imread('database/o7.bmp'));
o8=~im2bw(imread('database/o8.bmp'));
o9=~im2bw(imread('database/o9.bmp'));
o0=~im2bw(imread('database/o0.bmp'));

%%%%%%%% NEW NUM %%%%%%%
n1=~im2bw(imread('database/ln1.bmp'));
n2=~im2bw(imread('database/ln2.bmp'));
n3=~im2bw(imread('database/ln3.bmp'));
%n4=~im2bw(imread('database/ln4.bmp'));
n5=~im2bw(imread('database/ln5.bmp'));
n6=~im2bw(imread('database/ln6.bmp'));
n7=~im2bw(imread('database/ln7.bmp'));
n8=~im2bw(imread('database/ln8.bmp'));
n9=~im2bw(imread('database/ln9.bmp'));
n0=~im2bw(imread('database/ln0.bmp'));
ndot=im2bw(imread('database/lndot.bmp'));
%%%%%%%%% CREATE CELL %%%%%%
global new
global old

%old=[oa ob oc od oe of og oh oj ok ol om on op oq or os ot ou ov ow ox oy oz o1 o2 o3 o4 o5 o6 o7 o8 o9 o0];
new=[na nb nc nd ne nf ng nh nj nk nl nm nn np nq nr ns nt nu nv nw nx ny nz n1 n2 n3 n5 n6 n7 n8 n9 n0 ndot];
old=[oa ob oc od oe of og oh oj ok ol om on op oq or os ot ou ov ow ox oy oz o1 o2 o3 o4 o5 o6 o7 o8 o9 o0];
dbo=mat2cell(old,42,[23 23 23 23 23 23 23 ...
    23 23 23 23 23 23 23 ...
    23 23 23 23 23 23 23 ...
    23 23 23 23 23 23 23 ...
    23 23 23 23 23 23]);
%%%%% !!!!!!新式車牌的字體大小尚須確認!!!!!! %%%%%%%%%%%%
dbn=mat2cell(new,126,[63 63 63 63 63 63 63 ...
    63 63 63 63 63 63 63 ...
    63 63 63 63 63 63 63 ...
    63 63 63 63 63 63 63 ...
    63 63 63 63 63 63]);
save ('dbn','dbn')
save ('dbo','dbo')
clear
