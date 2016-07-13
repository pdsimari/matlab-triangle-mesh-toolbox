function mesh = meshSimplify(mesh, r)

% Patricio Simari
% April 2013
%
% mesh = meshSimplify(mesh, r)
%
% A wrapper for Matlab's built-in reducepatch function. Reduces the number
% of faces of the mesh, while attempting to preserve its overall shape. 
% The reduction factor r is interpreted in one of two ways: 
%
% * If r is less than 1, r is interpreted as a fraction of the original 
% number of faces. For example, if you specify r as 0.2, then the number 
% of faces is reduced to 20% of the number in the original patch.
% 
% * If r is greater than or equal to 1, then r is the target number of 
% faces. For example, if you specify r as 400, then the number of faces 
% is reduced until there are 400 faces remaining.
%
% See also reducepatch.

[nf, nv] = reducepatch(mesh.F', mesh.V', r);
mesh.F = nf';
mesh.V = nv';
