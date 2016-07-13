function meshPlotCurvature(mesh, X, p)

% Patricio Simari
% April 2013
%
% meshPlotCurvature(mesh, X)
%
% Display the mesh using the linear curvature values (e.g. mean or 
% principal) in X to infer colors. Zero is mapped ot the center of the
% colormap and maximum is scaled using an inverse fraction of the mesh's
% bounding box diagonal. The fraction is .02 by default. 
%
% meshPlotCurvature(mesh, X, p)
%
% Allows to set the fraction p to a value different than .02.
%
% See also meshPlot, meshBoundingBoxDiagonal.

if nargin < 3
    p = .02;
end

res = 128;
cmap = colormap(jet(res));
m = floor(.5*res) + 1;

d = meshBoundingBoxDiagonal(mesh);

max_abs = 1/(p*d);

% map to the [-1,1] interval
X(X > max_abs) = max_abs;
X(X < -max_abs) = -max_abs;
X = X./max_abs;

% map to the [1,res] interval with 0 at the midle m
X = round(((X + 1)*res)*.5);
X(X<1) = 1;
X(X>res) = res;

meshPlot(mesh, cmap(X,:));