function meshPlot(mesh, colors)

% Patricio Simari
% April 2013
%
% meshPlot(mesh)
%
% Display the mesh. Use the "Rotate 3D" tool in the menu tool strip to 
% orbit the camera.
%
% meshPlot(mesh, colors)
% 
% Display the mesh with colors mapped onto the surface. The length of
% colors can be equal to the number of vertices or faces. If the former,
% face colors will be interpolated.
%
% See also meshLoad, meshExport.

h = trimesh(mesh.F',mesh.V(1,:)',mesh.V(2,:)',mesh.V(3,:)', ...
    'FaceColor', 'w', 'EdgeColor', 'k', 'AmbientStrength', 0.7, ...
    'FaceLighting', 'phong', 'EdgeLighting', 'none');

if nargin > 1
    
    set(h, 'EdgeColor', 'none');
    
    if size(colors,1) < size(colors,2)
        colors = colors';
    end
    
    if ~isnumeric(colors)
        colors = +colors;
    end
    
    if size(colors,1) == size(mesh.V,2)
        set(h, 'FaceColor', 'interp');
    elseif size(colors,1) == size(mesh.F,2)
        set(h, 'FaceColor', 'flat');
    else
        error('Length of color parameter must be equal to the number of vertices or faces of the mesh.');
    end
    
    set(h, 'FaceVertexCData', colors);
    
end

set(gcf, 'Color', 'w');
set(gcf, 'Renderer', 'OpenGL');
set(gca, 'Projection', 'perspective');

axis equal;
axis tight;
axis off;

%camlight;