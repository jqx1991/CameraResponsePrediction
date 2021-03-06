function [RBF, Coefs,Mu_Opt,sigma_Opt] = RBFFitting(X,P,N,center)
sigma0 = (max(X)-min(X))/(N+1);
Mu0 = center-(N-1)*sigma0/2 : sigma0 : center+(N-1)*sigma0/2;
% x(1): central wavelength of the center gauss function
% x(2): wavelength interval of two adjacent gauss functions
% x(3): sigma
B = @(x) GaussFncSetCreate(X,N,[x(1)-(N-1)*x(2)/2 : x(2) : x(1)+(N-1)*x(2)/2], x(3));
P_est = @(x) B(x)*pinv(B(x))*P;
costfun = @(x) mean2((P-P_est(x)).^2);
A = [-1 (N-1)/2 0;...
      1 (N-1)/2 0;...
      0 -1.5 1];
b = [0; 780; 0];
% Three constraints:
% 1. x(1)-(N-1)*x(2)/2 > 0
% 2. x(1)+(N-1)*x(2)/2 < 780
% 3. x(3) < 1.5*x(2)
Opt = fmincon(costfun,[center;sigma0;sigma0],A,b);
Mu_Opt = Opt(1)-(N-1)*Opt(2)/2 : Opt(2) : Opt(1)+(N-1)*Opt(2)/2;
sigma_Opt = Opt(3);
clear B P_est
RBF = GaussFncSetCreate(X,N,Mu_Opt,sigma_Opt);
Coefs = pinv(RBF)*P;
end
function F = GaussFncSetCreate(X,N,Mu,sigma)
F = zeros(length(X),N);
for i = 1:N
    F(:,i) = exp(-(X-Mu(i)).^2/(sigma^2));
end
end
