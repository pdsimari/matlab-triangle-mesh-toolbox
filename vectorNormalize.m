function Vs = vectorNormalize(Vs)

% Patricio Simari
% April 2013
%
% Vs = vectorNormalize(Vs)
%
% Normalizes the colum vectors Vs; i.e. Vs(:,k) will have norm 1 for all k.

% compute norms
n = sqrt(sum(Vs.^2,1));

% divide each dimension d by the norm
for d = 1:size(Vs,1)
    Vs(d,:) = Vs(d,:)./n;
end