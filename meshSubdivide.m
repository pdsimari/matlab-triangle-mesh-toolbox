function mesh = meshSubdivide(mesh, n)

% Patricio Simari
% July 2013
%
% mesh = meshSubdivide(mesh)
%
% Perform a simple 1 to 4 subdivision of the mesh. Vertices are added at
% the midpoints of edges and each face is subdivided into 4 new faces
% joining the vertices. This is a (trivially) simple subdivision scheme and
% makes no attempt to converge to a smooth surface. It is only intended to
% increase the resolution of coarse meshes.
%
% mesh = meshSubdivide(mesh, n)
%
% Performs n subdivisions. Default value is 1.
%
% See also meshReduce.

if nargin < 2
    n = 1;
end

if n < 0 || fix(n) ~= n
    error('Argument n must be an integer number of subdivision steps.')
end

if n > 0
    for k = 1:n
        mesh = meshSubdivide1(mesh);
    end
end

end

% -------------------------------------------------------------------------
function mesh = meshSubdivide1(mesh)

donormals = isfield(mesh,'Nv');

V = mesh.V;
F = mesh.F;

if donormals
    Nv = mesh.Nv;
end

v = size(V,2);
E = sparse(v,v);

% create all edge midpoints and store them in a table

% Preallocate space for new verts
V(:,end+1:4*v) = 0;

if donormals 
    Nv(:,end+1:4*v) = 0;
end

% for each face
for f = 1:size(F,2)

    % for every pair of face vertices
    for i = 1:2
        for j = i+1:3

            % if we haven't seen this edge yet
            if ~E(F(i,f),F(j,f))

                % create a new mid-way point
                v = v + 1;
                V(:,v) = (V(:,F(i,f)) + V(:,F(j,f)))/2;
                
                if donormals
                    Nv(:,v) = (Nv(:,F(i,f)) + Nv(:,F(j,f)))/2;
                    Nv(:,v) = normalize(Nv(:,v));
                end

                % and store the reference to it
                E(F(i,f),F(j,f))= v;
                E(F(j,f),F(i,f))= v;
            end
        end
    end
end

% trim unused vert space
V(:,v+1:end) = [];

if donormals
    Nv(:,v+1:end) = [];
end

% re-triangulate according to the table

% resize F to accomodate new faces
F(4:12,:) = 0;

% for each face
for f = 1:size(F,2);
    
    % collect appropriate vertex indices
    i = F(1,f);
    j = F(2,f);
    k = F(3,f);
    a = E(i,j);
    b = E(j,k);
    c = E(k,i);
    
    % create the four new sub-faces
    F( 1: 3,f) = [i;a;c];
    F( 4: 6,f) = [a;j;b];
    F( 7: 9,f) = [c;b;k];
    F(10:12,f) = [a;b;c];    

end

mesh = meshClearFields(mesh);

% reshuffle faces to correct size/order
F = reshape(F,3,[]);
mesh.V = V;
mesh.F = F;

if donormals
    mesh.Nv = Nv;
end

end