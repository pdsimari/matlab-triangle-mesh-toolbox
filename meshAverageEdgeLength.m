function e = meshAverageEdgeLength(mesh)

% Patricio Simari
% April 2013
%
% e = meshAverageEdgeLength(mesh)
%
% Returns the average length of the edges of the mesh. This is a common 
% estimate of the mesh resolution used for setting resolution-dependent
% parameters.
%
% See also meshBoundingBoxDiagonal, meshBoundingBoxVolume.

e1 = mean(sqrt(sum((mesh.V(:,mesh.F(1,:)) - mesh.V(:,mesh.F(2,:))).^2)));
e2 = mean(sqrt(sum((mesh.V(:,mesh.F(2,:)) - mesh.V(:,mesh.F(3,:))).^2)));
e3 = mean(sqrt(sum((mesh.V(:,mesh.F(1,:)) - mesh.V(:,mesh.F(3,:))).^2)));

e = (e1 + e2 + e3)/3;
