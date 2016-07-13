function vol = meshBoundingBoxVolume(mesh)

% Patricio Simari
% April 2013
%
% vol = meshBoundingBoxVolume(mesh)
%
% Returns the volume of the mesh's axis-aligned bounding box.
%
% See also meshBoundingBoxDiagonal, meshAverageEdgeLength.

vol = prod(max(mesh.V(1:3,:),[],2) - min(mesh.V(1:3,:),[],2));