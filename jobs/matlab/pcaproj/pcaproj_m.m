function m = pcaproj_m(x,y)

p = pcaproj(x,y);
q = pcaproj(y,y);
m = (p-q)./(p+q);
