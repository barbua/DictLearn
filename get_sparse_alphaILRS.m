function alpha= get_sparse_alphaILRS( x,Dict,p )

[sz,k]=size(Dict);
n=size(x,2);
alpha=ones(k,n);
l=0;
eps=1e-6;
alphaj=zeros(256,1);
er=zeros(10001,1);
for i=1:n
    y=x(:,i);
    % initial alphai
    alphai=alpha(:,i);
    pnorm=[];
    while l<10000
        if l==0
            e=0;
        else
            e=1/l;
        end
      w=(alphai.^2+e).^(p/2-1);
      Q=diag(1./w);
      alphaj=Q*Dict'*((Dict*Q*Dict'+eye(sz)*0.00001)\y);
      pnorm=[pnorm,sum(abs(alphaj).^p)^(1/p)];
      er(l+1,1)=sum((alphaj-alphai).^2);
      if sum((alphaj-alphai).^2)<eps
          break;
      else
          alphai=alphaj;
      end
      l=l+1;
    end
    alpha(:,i)=alphaj;
end

