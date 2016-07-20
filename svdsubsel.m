function ind = svdsubsel(M,k)
[rowNum, colNum] = size(M);
if ~exist('k','var')
    k = colNum;
end
[Us, Ss, Vs] = svd(M./repmat(sqrt(sum(M.^2)/(rowNum-1)),rowNum,1),'econ');
Us = Us(:,1:min(rowNum,k));
[U, S, V] = svd(M,'econ');
n = find(diag(S)<10E-16);
if ~isempty(n)
    if k >= n(1)
        k = n -1;
        disp('k was reduced to match the rank of A');
    end
end
[~,~,pivot] = qr(Vs(:,1:k)','vector');
ind = sort(pivot(1:k));


