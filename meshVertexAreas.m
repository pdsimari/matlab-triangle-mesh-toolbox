function mesh = meshVertexAreas(mesh)

% Patricio Simari
% April 2013
%
% mesh = meshVertexAreas(mesh)
%
% Adds the field Av such that mesh.Av(i) contains the area associated
% with vertex mesh.V(:,i). It is computed baricentrically as 1/3 the sum of
% areas of all faces incident on said vertex.
%
% See also meshFaceAreas.

% get face areas
if ~isfield(mesh,'Af')
    mesh = faceAreas(mesh);
end

mesh.Av = zeros(1,size(mesh.V,2));
for f = 1:size(mesh.F,2)
    mesh.Av(mesh.F(:,f)) = mesh.Av(mesh.F(:,f)) + mesh.Af(f)/3;
end
