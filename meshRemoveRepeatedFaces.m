function mesh = meshRemoveRepeatedFaces(mesh)

% Patricio Simari
% Aug 1, 2013
%
% mesh = meshRemoveRepeatedFaces(mesh)
%
% Remove those faces which appear multiple times; i.e., those having
% identical vertex references (without considering order).

disp('Removing repeated faces...');
dispPercent(0);
tic;

F = sort(mesh.F,1);
numfaces = size(F,2);

del = false(1,size(F,2));

for i = 1:numfaces
    if ~del(i)
        for j = (i+1):numfaces
            if ~del(j) && F(1,i) == F(1,j) && F(2,i) == F(2,j) && F(3,i) == F(3,j)
                del(j) = true;
            end
        end
    end
end

mesh.F(:,del) = [];
fprintf('%d faces removed', sum(del));