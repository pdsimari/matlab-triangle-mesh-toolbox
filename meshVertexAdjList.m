function mesh = meshVertexAdjList(mesh)

% Patricio Simari
% April 2013
%
% mesh = meshVertexAdjList(mesh)
%
% Add the field vertexAdjList to the mesh structure such that
% mesh.vertexAdjList{i} contains the indices of all vertices adjacent to
% vertex i.

vertexAdjList = cell(1,size(mesh.V,2));

for f = 1:size(mesh.F,2)
    ind = mesh.F(:,f)';
    vertexAdjList{ind(1)} = [vertexAdjList{ind(1)},ind(2),ind(3)];
    vertexAdjList{ind(2)} = [vertexAdjList{ind(2)},ind(1),ind(3)];
    vertexAdjList{ind(3)} = [vertexAdjList{ind(3)},ind(1),ind(2)];
end

for v = 1:size(mesh.V,2)
    vertexAdjList{v} = unique(vertexAdjList{v});
end

mesh.vertexAdjList = vertexAdjList;