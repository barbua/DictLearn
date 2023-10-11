clear all;
data=double(imread('lena.png'))/255;
I=imresize(data,0.25);
X=im2col(I,[9 9],'sliding'); % extract 8 x 8 patches

X=X-repmat(mean(X),[size(X,1) 1]); % ???

sx=std(X);
X=X ./ repmat(sqrt(sum(X.^2)),[size(X,1) 1]); % ???

sz=size(X);
j=randperm(sz(2));
r=X(:,j(1:1024));
D=r;
[m,k]=size(D);
n=size(X,2);
T=20;
if 0
    e1=zeros(1,T);
    numiter1=zeros(1,T);
    tic;
    for j=1:T
        alpha=get_sparse_alpha_LARS(X,D,4);
        sa=sum(alpha,2);
        D(:,sa==0)=[];
        X(:,sa==0)=[];
        alpha(sa==0,:)=[];
        [m,k]=size(D);
        A=alpha*alpha';
        B=X*alpha';
        [D,numiter1(j)]=learn_dic(A,B,D);
        X1=D*alpha;
        e1(j)=mean((X1(:)-X(:)).^2);
        [j,e1(j)]
    end
    tlars=toc;
    display(['time:',num2str(tlars)]);
    e1=e1/size(X,2);
    save dic1024lenalars4 D alpha e1 numiter1;
end

nIter=200;
eta=0.01;
mu=200;
D=r;
numiter2=zeros(1,T);
e2=zeros(1,T);
tic;
for j=1:T
    alpha=get_sparse_alphafsa(X,D,3,eta,nIter,mu);
    B=alpha*alpha';
    C=X*alpha';
    [D,numiter2(j)]=learn_dic(B,C,D);
    X1=D*alpha;
    e2(j)=mean((X1(:)-X(:)).^2);
    [j,e2(j)]
end
tfsa=toc;
display(['time:',num2str(tfsa)]);
 save dic1024lenafsa3 D e2 numiter2 tfsa;


figure(1);
% hold on
% plot(e1);
plot(e2);
% h=legend('lars','fsa');
