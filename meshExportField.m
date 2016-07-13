function meshExportField(field, file)

% Patricio Simari
% May 2013
%
% meshExportField(field, file)
%
% Export the values in field to a file in dat format, a plain text file in
% which the first line is the number of entries, and every subsequent line
% are the field value in the given order.

fid = fopen(file, 'w');
fprintf(fid, '%d\n', numel(field));
fprintf(fid, '%f\n', field);
fclose(fid);
