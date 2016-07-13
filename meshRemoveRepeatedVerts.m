function [mesh, Del] = meshRemoveRepeatedVerts(mesh, tol)

% Patricio Simari
% Aug 1, 2013
%
% [mesh, Del] = meshRemoveRepeatedVerts(mesh, tol)
%
% Remove the repeated (duplicate) vertices from the given mesh; i.e., those
% that appear multiple more than once with the same coordinates. 

if nargin < 2
    tol = realmin('single');
end

disp('Finding duplicate vertices...');

Del = zeros(2,1);
last = 0;

n = size(mesh.V,2);

for i = 1:n
    for j = (i+1):n
        if max(abs(mesh.V(:,i) - mesh.V(:,j))) < tol
            last = last + 1;
            Del(:,last) = [i;j];
        end
    end
end

fprintf('%d duplicate vertices found.\n', last);

if last > 0
    
    disp('Removing...')
    for i = 1:last
        mesh.F(mesh.F == Del(2,i)) = Del(1,i);
    end
    
    disp('Correcting face indices...');
    VertIndices = unique(mesh.F(:));
    mesh.V = mesh.V(:,VertIndices);
    [~, mesh.F] = ismember(mesh.F,VertIndices);
    
end

disp('Done');


