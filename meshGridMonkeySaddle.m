function mesh = meshGridMonkeySaddle(n, xmin, xmax, ymin, ymax)

% Patricio Simari
% April 2013
%
% mesh = meshGridMonkeySaddle(n, xmin, xmax, ymin, ymax)
%
% Create a mesh of a grid-sampled monkey saddle using an n x n grid; i.e. 
% the function z = x^3 - 3xy^2 with x in [xmin,xmax] and y in [ymin,ymax].
% The fields mesh.h and mesh.k will contain the analytic values of mean 
% and Gaussian curvature, respectively.
%
% Source:
% http://www.wolframalpha.com/entities/surfaces/monkey_saddle/sw/l0/lp/

[X,Y] = meshgrid(linspace(xmin,xmax,n),linspace(ymin,ymax,n));
Z = X.^3 - 3*X.*(Y.^2);

[mesh.F,mesh.V] = surf2patch(X,Y,Z,'triangles');

mesh.F = mesh.F';
mesh.V = mesh.V';

u = mesh.V(1,:);
v = mesh.V(2,:);

mesh.h = (-27*u.*(u.^2 - 3*v.^2).*(u.^2 + v.^2))./ ...
         ((9*(u.^2 + v.^2).^2 + 1).^(3/2));
mesh.k = (-36*(u.^2 + v.^2))./((9*(u.^2 + v.^2).^2 + 1).^2);
