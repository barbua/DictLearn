function alpha= get_sparse_alphafsa( x,Dict,num,eta,niter,mu )
[m,k]=size(Dict);
n=size(x,2);
alpha=zeros(k,n);
for i=1:n
    y=x(:,i);
    [b,b0,ib]=trainLinFSA(Dict,y,4,num,0.000,eta,niter,mu,0.9,32,0);
    alpha(ib,i)=b;
end
