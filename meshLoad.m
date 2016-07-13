function mesh = meshLoad(filestr)

% Patricio Simari
% April 2013
%
% mesh = meshLoad(mesh, filestr)
%
% Loads a mesh from a plain ascii file in a format corresponding to the
% extension provided. Currently .obj, .off, .ply, and .tri formats are 
% supported.
%
% mesh.V is a 3 x n matrix where mesh.V(:,i) contains the x,y,z coordinates
% of the i-th vertex.
%
% mesh.F is a 3 x m matrix where mesh.F(:,j) contains the indices of the
% three vertices forming the j-th triangular face. 
%
% See also meshPlot, meshExport.

if strcmpi(filestr(end-3:end),'.obj')
    mesh = meshLoadObj(filestr);
elseif strcmpi(filestr(end-3:end),'.off')
    mesh = meshLoadOff(filestr);
elseif strcmpi(filestr(end-3:end),'.ply')
    mesh = meshLoadPly(filestr);
elseif strcmpi(filestr(end-3:end),'.tri')
    mesh = meshLoadTri(filestr);
else
    error('Unsupported file format. Currently only .obj and .off formats are supported.');
end

% -------------------------------------------------------------------------
function mesh = meshLoadTri(filestr)

file = fopen(filestr);

V = [0;0;0];
F = [0;0;0];

% parse number of vertices
line = strtrim(fgetl(file));
numverts = eval(line);

% pre-allocate space for vertices
mesh.V = zeros(3, numverts);

% read vertices
for curvert = 1:numverts
    
    line = strtrim(fgetl(file));
    
    for k = 1:3
        [token,line] = strtok(line);
        V(k) = eval(token);
    end
    
    mesh.V(:, curvert) = V;
    
    if feof(file) && (curvert < numverts)
        error('Unexpected end of file.');
    end
    
end

% parse number of faces
line = strtrim(fgetl(file));
numfaces = eval(line);

% read faces
for curface = 1:numfaces
    
    line = strtrim(fgetl(file));
    
    for k = 1:3
        [token,line] = strtok(line);
        % + 1 corrects for 0-based indexing
        F(k) = eval(token) + 1;
    end
    
    mesh.F(:, curface) = F;
    
    if feof(file) && (curface < numfaces)
        error('Unexpected end of file.');
    end
    
end

fclose(file);

% -------------------------------------------------------------------------
function mesh = meshLoadOff(filestr)

file = fopen(filestr);

V = [0;0;0];
F = [0;0;0];

% skip header line containing "OFF"
fgetl(file);

% parse number of vertices and faces in second line
line = strtrim(fgetl(file));
[token,line] = strtok(line);
numverts = eval(token);
[token,line] = strtok(line);
numfaces = eval(token);

% pre-allocate space for mesh
mesh.V = zeros(3, numverts);
mesh.F = zeros(3, numfaces);

% skip empty header lines
line = strtrim(fgetl(file));
while (isempty(line) || line(1) == '#') && ~feof(file)
    line = strtrim(fgetl(file));
end

% read vertices
for curvert=1:numverts
    
    k = 0;
    while k < 3 && ~isempty(line)
        k = k + 1;
        [token,line] = strtok(line);
        V(k) = eval(token);
    end
    
    mesh.V(:, curvert) = V;
    
    if feof(file)
        error('Unexpected end of file');
    end
    line = strtrim(fgetl(file));
    
end

non_triangle_warning_issued = false;
t = 1;

% read faces
for curface=1:numfaces
    
    [token,line] = strtok(line);
    if (eval(token) ~=3) && (~non_triangle_warning_issued)
        error('Non-triangular faces not supported in mesh format.');
        non_triangle_warning_issued = true;
    end
    
    k = 1;
    while ~isempty(line) && (k <= 3)
        [token,line] = strtok(line);
        F(k) = eval(token) + 1;
        k = k + 1;
    end
    
    mesh.F(:,t) = F;
    t = t + 1;
    
    if ~feof(file)
        line = strtrim(fgetl(file));
    end
end

fclose(file);

% -------------------------------------------------------------------------
function mesh = meshLoadObj(filestr)

file = fopen(filestr);

mesh.V = [];
mesh.F = [];

V = [0;0;0];
F = [0;0;0];

while ~feof(file)
    
    line = strtrim(fgetl(file));
    [token,line] = strtok(line);
    
    % lines that begin with a "v" are vertices
    if strcmp(token, 'v')
        
        k = 0;
        while k < 3 && ~isempty(line)
            k = k + 1;
            [token,line] = strtok(line);
            V(k) = eval(token);
        end
        if k > 3
            error('Read vertex with more than 3 coordinates.');
        end
        mesh.V = [mesh.V, V];
        
    % lines that begin with "f" are faces
    elseif strcmp(token, 'f')
        
        k = 0;
        while k < 3 && ~isempty(line)
            k = k + 1;
            [token,line] = strtok(line);
            token = strtok(token,'/');
            F(k) = eval(token);
        end
        if k > 3
            error('Read face with more than 3 indices. Only triangular meshes are currently supported.');
        end
        mesh.F = [mesh.F, F];
        
    end
    
end
fclose(file);

% -------------------------------------------------------------------------
function mesh = meshLoadPly(file)

fid = fopen(file);

% find number of vertices and faces
s = [];
for i = 1:2 
    while ~strcmpi(s, 'element')
        s = fscanf(fid, '%s[^ \n]');
    end
    s = fscanf(fid, '%s[^ \n]');
    if strcmpi(s, 'vertex')
        nverts = fscanf(fid, '%d');
    else
        nfaces = fscanf(fid, '%d');
    end
end

% skip rest of the header
while ~strcmpi(s, 'end_header')
    s = fscanf(fid, '%s[^ \n]');
end

mesh.V = zeros(3, nverts);
for i = 1:nverts
    mesh.V(:,i) = fscanf(fid, '%lg %lg %lg', [1 3])';
end

mesh.F = zeros(4, nfaces);
for i = 1:nfaces
    mesh.F(:,i) = fscanf(fid, '%d %d %d %d', [1 4])';
end
mesh.F = mesh.F(2:4,:) + 1;

fclose(fid);

