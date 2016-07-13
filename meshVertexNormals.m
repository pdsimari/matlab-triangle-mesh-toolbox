function mesh = meshVertexNormals(mesh)

% Patricio Simari
% April 2013
%
% mesh = meshVertexNormals(mesh)
% 
% Adds the field mesh.Nv such that mesh.Nv(:,i) contains the unit normal 
% vector of vertex mesh.V(:,i) computed as the area-weighted average of the
% normals of all faces incident on said vertex.
%
% See also meshFaceNormals.

if ~isfield(mesh,'Nf')
    mesh = meshFaceNormals(mesh);
end
if ~isfield(mesh,'Af')
    mesh = meshFaceAreas(mesh);
end

mesh.Nv = zeros(size(mesh.V));
for f = 1:size(mesh.F,2)
    mesh.Nv(:,mesh.F(:,f)) = mesh.Nv(:,mesh.F(:,f)) + mesh.Nf(:,[f,f,f])*mesh.Af(f);
end

mesh.Nv = vectorNormalize(mesh.Nv);

