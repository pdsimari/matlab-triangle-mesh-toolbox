function mesh = meshReduce(mesh, r)

% Patricio Simari
% June 2013
%
% mesh = meshReduce(mesh, r)
%
% Simplify the mesh using Matlab's reducepatch function. If r is in [0, 1],
% it indicates the fraction of the original faces desired in the output.
% If r > 1, then it indicates the total number of faces desired.
%
% See also reducepatch, meshSubdivide.


[nf, nv] = reducepatch(mesh.F',mesh.V(1:3,:)',r);
mesh.F = nf';
mesh.V = nv';