function mesh = meshGridExplicitFunction(fstring, n, xmin, xmax, ymin, ymax)

% Patricio Simari
% April 2013
%
% mesh = meshGridExplicitFunction(fstring, n, xmin, xmax, ymin, ymax)
%
% Create a mesh with a grid-sampled x,y domain using an n x n grid. The z 
% value is generated evaluating the function given by fstring with x in 
% [xmin,xmax] and y in [ymin,ymax]. To retrieve the analytic curvature
% values, use the symbolicCurvature2D function.
%
% Example:
%
% mesh = meshGridExplicitFunction('.4*(x^2 - y^2)', 20, -1, 1, -1, 1);
% h = symbolicCurvature2D('.4*(x^2 - y^2)', mesh.V);
%
% See also meshGridMonkeySaddle, meshGridTorus, symbolicCurvature2D.

f = inline(fstring,'x','y');

[X,Y] = meshgrid(linspace(xmin,xmax,n),linspace(ymin,ymax,n));
Z = zeros(size(X));

for k = 1:numel(Z)
    Z(k) = f(X(k),Y(k));
end

[mesh.F,mesh.V] = surf2patch(X,Y,Z,'triangles');

mesh.F = mesh.F';
mesh.V = mesh.V';
