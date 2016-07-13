function meshPlotNormals(mesh, type)

% Patricio Simari
% Aug 1, 2013
% 
% meshPlotNormals(mesh)
%
% Plots the vertex normals of the given mesh.
%
% meshPlotNormals(mesh, type)
%
% Plots the mesh normals of the given type. Accepted values are 'face' and
% 'vertex' (default).

if nargin < 2
    type = 'vertex';
end

if strcmpi(type, 'face')
    
    if ~isfield(mesh,'Nf')
        mesh = meshFaceNormals(mesh);
    end
    
    if ~isfield(mesh,'C')
        mesh = meshFaceCenters(mesh);
    end
    
    hold on;
    meshPlot(mesh);
    quiver3(mesh.C(1,:)',  mesh.C(2,:)',  mesh.C(3,:)', ...
            mesh.Nf(1,:)', mesh.Nf(2,:)', mesh.Nf(3,:)');
    hold off;
    
elseif strcmpi(type, 'vertex')
    
    if ~isfield(mesh,'Nv')
        mesh = meshVertexNormals(mesh);
    end
    
    hold on;
    meshPlot(mesh);
    quiver3(mesh.V(1,:)', mesh.V(2,:)', mesh.V(3,:)', ...
        mesh.Nv(1,:)', mesh.Nv(2,:)', mesh.Nv(3,:)');
    hold off;
    
else
    error('Unrecognized normal type %s', type);
end
