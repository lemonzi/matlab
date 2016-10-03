function deriv = deriv9point(data, sr)
% Computes a zero-padded 9-point derivative of the input data
% If the second argument is a scalar, it is assumed to be the sr
% If it is a vector, it is assumed to be timestamps (non-uniform sr)

    % Normalization factor and conversion to time
    if isscalar(sr)
        uniform = true;
        invh = sr / 840;
    elseif std(diff(sr)) == 0
        uniform = true;
        invh = sr(1) / 840;
    else
        uniform = false;
        medsr = median(sr);
        tpad = [sr(1) - (1:5)' * medsr; sr(:); sr(end) + (1:4)' * medsr];
    end

    % Init output buffer
    deriv = zeros(size(data));

    % Zero-padding
    data = [zeros(5,1); data(:); zeros(4,1)];

    % Compute
    for i = 1:length(deriv)
        wind = data(i:i+8);
        if uniform
            deriv(i) = [3 -32 168 -672 0 672 -168 32 -3] * wind * invh;
        else
            wt = tpad(i:i+8);
            wdt = diff(wt);
            if all(abs(wdt - medsr) < (0.1 * medsr))
                % Locally uniform sample rate
                invh = 1 / (wdt(1) * 840);
                deriv(i) = [3 -32 168 -672 0 672 -168 32 -3] * wind * invh;
            else
                % Non-uniform sample rate, no analytical expression
                coeff = polyfit(wt - wt(5), wind - wind(5), 2);
                deriv(i) = coeff(2);
            end
        end
    end

end

