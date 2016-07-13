function core = meshClearFields(mesh)

% Patricio Simari
% April 2013
%
% core = meshClearFields(mesh)
%
% Returns a copy of the mesh structure that only contains the V and F
% fields and no other computed attributes (e.g. normals, centroids, areas,
% etc.)

core.V = mesh.V;
core.F = mesh.F;
