function [h, k, k1, k2] = symbolicCurvature2D(fstring, X)

% Patricio Simari
% August 2012
%
% [h,k] = symbolicCurvature(fstring, X)
%
% Given a symbolic expression as a string in fstring, using symbolic
% computing to compute the mean and Gaussian curvature at the domain points
% given in X. In other words, h(i) and k(i) contain the mean and Gaussian 
% curvature of the expression in fstring at point X(:,i). The function in
% fstring should use 'x', 'y'.

h = zeros(1,size(X,2));
k = zeros(1,size(X,2));

syms x y real
f = sym(fstring);
v = [x;y];

gradf = jacobian(f,v);
hessf = jacobian(gradf,v);

% make the parameters explicit in case they have been cancelled out
gradm = matlabFunction(gradf,'vars',{'x','y'});
hessm = matlabFunction(hessf,'vars',{'x','y'});

for n = 1:size(X,2)
    
    grad = gradm(X(1,n),X(2,n));
    hess = hessm(X(1,n),X(2,n));
    
    A = -(1/sqrt(1+sum(grad.^2)))*hess*inv(eye(2) + grad'*grad);
    
    e = eig(A);
    e = real(e);
    h(n)  = mean(e);
    k(n)  = prod(e);
    k1(n) = e(1);
    k2(n) = e(2);
    
end
