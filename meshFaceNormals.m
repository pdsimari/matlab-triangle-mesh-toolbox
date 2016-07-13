function mesh = meshFaceNormals(mesh)

% Patricio Simari
% April 2013
%
% mesh = meshFaceNormals(mesh)
% 
% Adds the field mesh.Nf such that mesh.Nf(:,i) contains the unit normal 
% vector of face mesh.F(:,i) computed as the cross product of face edges. 
% Outward direction is determined assuming counterclockwise vertex
% ordering.
%
% See also meshVertexNormals.

mesh.Nf(1:3,:) = cross(mesh.V(1:3,mesh.F(2,:)) - mesh.V(1:3,mesh.F(1,:)), ...
                       mesh.V(1:3,mesh.F(3,:)) - mesh.V(1:3,mesh.F(1,:)));

mesh.Nf = vectorNormalize(mesh.Nf);
