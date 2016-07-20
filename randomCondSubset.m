function ind = randomCondSubset(M,k,n)
COND = Inf;
[~,colNum] = size(M);
for i = 1:n
    ind_temp = randperm(colNum,k);
    M_sub = M(:,ind_temp);
    if cond(M_sub)<COND
        COND = cond(M_sub);
        ind = ind_temp;
    end
end