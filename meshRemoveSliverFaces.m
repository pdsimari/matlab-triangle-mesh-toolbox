function mesh = meshRemoveSliverFaces(mesh)

% Patricio Simari
% Aug 1, 2013
%
% mesh = meshRemoveSliverFaces(mesh)
%
% Remove the 'sliver' faces from the given mesh; i.e., those faces
% containing repeated indices. 

isSliver = (mesh.F(1,:) == mesh.F(2,:)) | ...
           (mesh.F(2,:) == mesh.F(3,:)) | ...
           (mesh.F(1,:) == mesh.F(3,:));

mesh.F(:,isSliver) = [];
fprintf('Done. %d faces removed.\n', sum(isSliver));
