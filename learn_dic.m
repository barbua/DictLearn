function [Dict,ii]= learn_dic(B,C,Dict)
% Dictionary update, Algorithm 3 from paper
ii=0;
eps=1e-6;
while ii<10000
    ii=ii+1;
    y=update_dic(B,C,Dict);
    if sum(sum((y-Dict).^2))<eps
        break;
    else
        Dict=y;
    end
end
Dict=y;
fprintf('number of interations for Dictionary Learning: %4.0f\n',ii);
end

function y= update_dic(B,C,Dict)
for j=1:size(Dict,2)
    if B(j,j)==0
        u=Dict(:,j);
    else
        u=(C(:,j)-Dict*B(:,j))/B(j,j)+Dict(:,j);
    end
    nu=norm(u,2);
    Dict(:,j)=u/max(nu,1);
end
y=Dict;
end