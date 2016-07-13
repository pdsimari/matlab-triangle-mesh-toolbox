function mesh = meshGridTorus(n, a, b)

% Patricio Simari
% April 2013
%
% mesh = meshGridTorus(n, a, b)
%
% Create a mesh of a grid-sampled torus of inner radius a and outer radius 
% b using an n x n grid. The fields mesh.h and mesh.k will contain the
% analytic values of mean and Gaussian curvature, respectively.
%
% Source:
%
% http://www.math.hmc.edu/~gu/curves_and_surfaces/surfaces/torus.html

    function ind = mysub2ind(i,j)
        i = mod(i-1,n) + 1;
        j = mod(j-1,n) + 1;
        ind = (i-1)*n + j;
    end

angs = linspace(0,2*pi,n+1);

mesh.V = zeros(3,n*n);
mesh.h = zeros(1,n*n);
mesh.k = zeros(1,n*n);

k = 1;
for u = angs(1:(end-1))
    for v = angs(1:(end-1))
        
        mesh.V(1,k) = cos(u)*(a + b*cos(v));
        mesh.V(2,k) = (a + b*cos(v))*sin(u);
        mesh.V(3,k) = b*sin(v);
        
        mesh.h(k) = -(a + 2*b*cos(v))/(2*b*(a + b*cos(v)));
        mesh.k(k) = cos(v)/(b*(a + b*cos(v)));
        
        k = k + 1;
    end
end

mesh.F = zeros(3,2*n*n);

k = 1;
for i = 1:n
    for j = 1:n
        mesh.F(:,k) = [mysub2ind(i,j); mysub2ind(i+1,j); mysub2ind(i+1,j+1)];
        k = k + 1;
        mesh.F(:,k) = [mysub2ind(i,j); mysub2ind(i+1,j+1); mysub2ind(i,j+1)];
        k = k + 1;
    end
end

end