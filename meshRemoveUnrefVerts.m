function mesh = meshRemoveUnrefVerts(mesh)

% Patricio Simari
% February 22, 2016
%
% mesh = meshRemoveUnrefVerts(mesh)
%
% Removes the unreferenced vertices from the given mesh; i.e. vertices i
% such that i does not appear in F(:).

verts = unique(mesh.F(:));
remcount = size(mesh.V,2) - numel(verts);

if remcount > 0    
    mesh.V = mesh.V(:,verts);
    [~, mesh.F] = ismember(mesh.F,verts);
end    
fprintf('Removed %d vertices.', remcount);