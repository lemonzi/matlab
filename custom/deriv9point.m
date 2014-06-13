function deriv = deriv9point(data, sr)
% Computes a zero-padded 9-point derivative of the input data

    % Normalization factor and conversion to time
    invh = sr / 840;

    % Init output buffer
    deriv = zeros(size(data));

    % Zero-padding
    data = [zeros(5,1); data(:); zeros(4,1)];

    % Compute
    for i = 1:length(data)
        data = wind(i:i+8);
        deriv(i) = [3 -32 168 -672 0 672 -168 32 -3] * wind(:) * invh;
    end

end