function lb = mgetLB(x,y)
[~,ind]=sort([y(:);x(:)]);
lb=mexGetLB(ind,numel(y),numel(x));
end