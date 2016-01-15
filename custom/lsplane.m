function [x0, a, d, normd] = lsplane(X)
% LSPLANE    Least-squares plane (orthogonal distance
%            regression). Typically, n = 3.
%
% Usage: [x0, a, (d), (normd)] = lsplane(X)
%
% Input
% X        Matrix [x y z] where x = vector of x-coordinates,
%          y = vector of y-coordinates and z = vector of
%          z-coordinates.
%          Dimension: m x n.
%
% Output
% x0       Centroid of the data = point on the best-fit plane.
%          Dimension: n x 1.
%
% a        Direction cosines of the normal to the best-fit plane.
%          Dimension: n x 1.
%
% d        Residuals. (optional)
%          Dimension: n x 1.
%
% normd    Norm of residual errors. (optional)
%          Dimension: 1 x 1.

    % check number of data points
    if size(X,1) < 3
        error('At least 3 data points required: ' )
    end

    % calculate centroid (as column vector)
    x0 = mean(X, 1)';

    % form matrix A of translated points
    A = bsxfun(@minus, X, x0');

    % find direction of minimum variance (a)
    [U, S, V] = svd(A, 0);
    [smin, idx] = min(diag(S));
    a = V(:, idx);

    % calculate residual distances, if required
    if nargout > 2
        d = U(:, idx) * smin;
        normd = norm(d);
    end

end

