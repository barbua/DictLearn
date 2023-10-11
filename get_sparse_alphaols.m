function alpha= get_sparse_alphaols( x,Dict,num )
[m,k]=size(Dict);
n=size(x,2);
alpha=zeros(k,n);
xx=Dict'*Dict+0.00001*eye(k);
for i=1:n
    y=x(:,i);
    b=xx\(Dict'*y);
    sb=sort(abs(b),'descend');
    thr=(sb(num)+sb(num+1))/2;
    ib=find(abs(b)>thr);
    X=Dict(:,ib);
    b=(X'*X)\(X'*y);
    alpha(ib,i)=b;
end
