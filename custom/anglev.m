function ang = anglev(v1, v2, units)
% ANGLEV(v1, v2, units)
% Computes the angle between vectors v1 and v2
% Or between each pair of vectors, if v1 and v2 are matrices or n-ices
% Units can be 'radians' or 'degrees' (defaults to 'radians')
% By default, the vectors take the first dimension (column vectors)

    % In which direction do the vectors go
    dim = 1;

    % Normalize vectors
    u1 = v1 ./ sqrt(sum(v1 .^ 2, dim));
    u2 = v2 ./ sqrt(sum(v2 .^ 2, dim));

    % Arc cosine of dot products
    ang = acos(sum(u1 .* u2, dim));

    % Convert to degrees if needed
    if nargin == 3 && strcmp(units, 'degrees')
        ang = ang * (180/pi);
    end

end