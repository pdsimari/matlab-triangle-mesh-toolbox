function d = meshBoundingBoxDiagonal(mesh)

% Patricio Simari
% April 2013
%
% d = meshBoundingBoxDiagonal(mesh)
%
% Returns the length of the diagonal of the mesh's axis-aligned bounding 
% box. This is a common estimate of scale used for setting scale-dependent
% parameters.
%
% See also meshBoundingBoxVolume, meshAverageEdgeLength.

d = sqrt(sum((max(mesh.V(1:3,:),[],2) - min(mesh.V(1:3,:),[],2)).^2));
