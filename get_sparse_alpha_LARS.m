function alpha= get_sparse_alpha_LARS( x,Dict,num )
% Sparsity using LARS
[m,k]=size(Dict);
n=size(x,2);
alpha=zeros(k,n);
for i=1:n
    y=x(:,i);
    alphai=lars(Dict,y,num);
    alphai=alphai(min(num+1,size(alphai,1)),:)';
    alpha(:,i)=alphai;
end
