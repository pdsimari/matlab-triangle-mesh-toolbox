function mesh = meshFaceCenters(mesh)

% Patricio Simari
% April 2013
%
% mesh = meshFaceCenters(mesh)
%
% Adds a field C to the mesh structure such that mesh.C(:,i) is the
% centroid of face mesh.F(:,i).
%
% See also meshFaceNormals.

mesh.C = (mesh.V(:,mesh.F(1,:)) + mesh.V(:,mesh.F(2,:)) + mesh.V(:,mesh.F(3,:)))/3;