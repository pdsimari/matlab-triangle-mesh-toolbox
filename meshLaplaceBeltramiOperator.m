function [K,A,H,B] = meshLaplaceBeltramiOperator(mesh)

% Patricio Simari
% April 2013
%
% [K,A,H,B] = meshLaplaceBeltramiOperator(mesh)
%
% Implements the Laplace-Beltrami operator as descibed by Meyer et
% al. K(:,i) is the curvature normal normal vector computed at vertex i. 
% A(i) is the mixed area at the vertex, H(i) is the mean curvature value. 
% B(i) is true if the neighborhood of the vertex was found to be "Voronoi 
% safe", and false otherwise. 
%
% For more details please see:
%
% M. Meyer, M. Desbrun, P. Schröder, and A. H. Barr, ?Discrete 
% differential-geometry operators for triangulated 2-manifolds,? 
% Visualization and mathematics, vol. 3, no. 7, pp. 34?57, 2002.

% precompute triangle areas if necessary 
if ~isfield(mesh,'Af')
    mesh = meshFaceAreas(mesh);
end

% initialize mixed area and K to zeros
A = zeros(1,size(mesh.V,2));
K = zeros(3,size(mesh.V,2));
B = false(1,size(mesh.V,2));

for f = 1:size(mesh.F,2)
   
   % get the three vertices of the current triangle face f
   x = mesh.F(1,f);
   y = mesh.F(2,f);
   z = mesh.F(3,f);
   
   % get the three edge vectors of the triangle
   xy = mesh.V(1:3,y) - mesh.V(1:3,x);
   xz = mesh.V(1:3,z) - mesh.V(1:3,x);
   yz = mesh.V(1:3,z) - mesh.V(1:3,y);
   
   % get the cosines of the angles at each vertex
   cosx = dot(vectorNormalize( xy),vectorNormalize( xz));
   cosy = dot(vectorNormalize(-xy),vectorNormalize( yz));
   cosz = dot(vectorNormalize(-xz),vectorNormalize(-yz));
   
   % get the respective cotangents
   cotx = cosx/sqrt(1-cosx*cosx);
   coty = cosy/sqrt(1-cosy*cosy);
   cotz = cosz/sqrt(1-cosz*cosz);
   
   % weight each edge vector by the opposite vertex cotangent
   cxy = xy*cotz;
   cxz = xz*coty;
   cyz = yz*cotx;
   
   % update each vertices k with all vectors that point into it
   K(:,x) = K(:,x) + 0.5*(-cxy - cxz);
   K(:,y) = K(:,y) + 0.5*( cxy - cyz);
   K(:,z) = K(:,z) + 0.5*( cxz + cyz);
   
   % update the mixed area
   % first check for obtuse angles...
   
   if cosx < 0
       
       A(x) = A(x) + mesh.Af(f)/2;
       A(y) = A(y) + mesh.Af(f)/4;
       A(z) = A(z) + mesh.Af(f)/4;
       
   elseif cosy < 0
       
       A(x) = A(x) + mesh.Af(f)/4;
       A(y) = A(y) + mesh.Af(f)/2;
       A(z) = A(z) + mesh.Af(f)/4;
       
   elseif cosz < 0
       
       A(x) = A(x) + mesh.Af(f)/4;
       A(y) = A(y) + mesh.Af(f)/4;
       A(z) = A(z) + mesh.Af(f)/2;
       
   else
       
       % no obtuse angles: Voronoi safe
       
       B(f) = true;
       
       axy = 0.125*cotz*sum(xy.^2,1);
       axz = 0.125*coty*sum(xz.^2,1);
       ayz = 0.125*cotx*sum(yz.^2,1);
       
       A(x) = A(x) + axy + axz;
       A(y) = A(y) + axy + ayz;
       A(z) = A(z) + axz + ayz;
   
   end
   
end

if nargout > 2
    H = .5*(sqrt(sum(K.^2,1))./A);
    
    % compute normals if necessary
    if ~isfield(mesh,'Nv')
        mesh = meshVertexNormals(mesh);
    end
    
    H = H.*sign(dot(K, mesh.Nv(1:3,:)));
end