function ind = minCondSubset(M,k)
Mt = M;
[~, colNum] = size(Mt);
[~,ind(1)] = max(sum(Mt.^2));
V(:,1) = Mt(:,ind(1));
Mt(:,ind(1)) = [];
for i = 1:k-1
    CN = cond([V,Mt(:,1)]);
    for j = 1:colNum-i
        if cond([V,Mt(:,j)]) <= CN
            CN = cond([V,Mt(:,j)]);
            temp = j;
        end
    end
    V = [V,Mt(:,temp)];
    Mt(:,temp) = [];
end
ind = find(all(ismember(M,V)));