function f = meshSmoothField(mesh, f, coeff, iter)

% Patricio Simari
% August 1, 2013
%
% f = meshSmoothField(mesh, f, coeff, iter)
%
% Apply Laplacian smoothing to f, which is assumed to be in one-to-one
% correspondence with the vertices of the mesh; i.e. f(i) is the field
% value of the i-th vertex.
%
% Note: this function assumes that the function meshVertexAdjList has been 
% invoked.
%
% See also vertexAdjList.

if ~isfield(mesh,'vertexAdjList')
    error(['Mesh smoothing requires precomputing vertexAdjList. ', ...
           'Invoke meshVertexAdjList function prior to invoking ', ...
           'meshSmoothField.']);
end

g = zeros(size(f));
for k = 1:iter
    for v = 1:size(mesh.V,2)
        g(v) = mean(f(mesh.vertexAdjList{v}));
    end
    f = (1-coeff)*f + coeff*g;
end
