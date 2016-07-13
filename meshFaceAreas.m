function mesh = meshFaceAreas(mesh)

% Patricio Simari
% April 2013
%
% mesh = meshFaceAreas(mesh)
% 
% Adds the field mesh.Af such that mesh.Af(i) contains the area of face 
% mesh.F(:,i).
%
% See also meshVertexAreas.

mesh.Af = 0.5*sqrt(sum((...
    cross(mesh.V(:,mesh.F(2,:)) - mesh.V(:,mesh.F(1,:)), ...
          mesh.V(:,mesh.F(3,:)) - mesh.V(:,mesh.F(1,:)))).^2,1));