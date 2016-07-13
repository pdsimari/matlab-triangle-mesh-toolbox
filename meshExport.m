function meshExport(mesh, filestr)

% Patricio Simari
% April 2013
%
% meshExport(mesh, filestr)
%
% Saves the mesh in a plain ascii file in a format corresponding to the
% extension provided. Currently .obj, .off and .tri formats are supported.
%
% See also meshLoad, meshPlot.

if strcmpi(filestr(end-3:end),'.obj')
   
    fid = fopen(filestr, 'w');
    fprintf(fid, 'g Mesh_0\n');
    fprintf(fid, 'v %f %f %f\n', mesh.V(1:3,:));
    fprintf(fid, 'f %d %d %d\n', mesh.F);
    fclose(fid);
    
elseif strcmpi(filestr(end-3:end),'.off')
    
    fid = fopen(filestr, 'w');
    fprintf(fid, 'OFF\n');
    fprintf(fid, '%d %d %d\n', size(mesh.V,2), size(mesh.F,2), 0);
    fprintf(fid, '%f %f %f\n', mesh.V(1:3,:));
    fprintf(fid, '3 %d %d %d\n', mesh.F - 1);
    fclose(fid);
    
elseif strcmpi(filestr((end-3):end),'.tri')
    
    fid = fopen(filestr, 'w');
    fprintf(fid, '%d\n', size(mesh.V,2));
    fprintf(fid, '%f %f %f\n', mesh.V(1:3,:));
    fprintf(fid, '%d\n', size(mesh.F,2));
    fprintf(fid, '%u %u %u\n', mesh.F - 1);
    fclose(fid);
    
else
    error('Unsupported file format. Supported formats are: .obj, .off, and .tri.');
end