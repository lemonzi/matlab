function zc = zerocrossing(data, Nl, Nr)
% Find zero-crossing points without non-zero-crossing neighbours
% Returns a logical, true on samples with zero-crossing on the right side
% Do find(zerocrossing(arguments)) to get the indices
% Usage:
%     zerocrossing(data, N)
%         Use an N-sample window on each side
%     zerocrossing(data, Nl, Nr)
%         Use an Nl-sample window on the left and Nr-sample on the right
%     zerocrossing(data, N, 'left')
%         Use an N-sample window on the left side, ignore right side
%     zerocrossing(data, N, 'right')
%         Use an N-sample window on the right side, ignore left side

    if nargin < 3
        Nr = Nl;
    end

    both = false;
    compare = @ne;
    switch Nr
        case 'left'
            Cl = true;
            Nr = 1;
        case 'right'
            Cl = false;
            Nr = Nl;
            Nl = 1;
        case 'up'
            compare = @gt;
            Nr = Nl;
            both = true;
        case 'down'
            compare = @lt;
            Nr = Nl;
            both = true;
        otherwise
            both = true;
    end

    % Normalize size
    sz = size(data);
    data = data(:);

    % Do some padding
    data = [ones(Nl,1)*data(1); data; ones(Nr,1)*data(end)];

    % Precompute indicators
    edges = diff(sign(data));

    % Matrices with windows
    Cidx = Nl:length(edges)-Nr;
    Lidx = bsxfun(@plus, (-Nl+1):0, Cidx');
    Ridx = bsxfun(@plus, 1:Nr,      Cidx');

    % Vectorized check of signs
    SSL  = all(edges(Lidx) == 0, 2);
    SSR  = all(edges(Ridx) == 0, 2);
    CSLR = compare(edges(Cidx), 0);

    % Apply rules
    if both
        zc = CSLR & (SSR | SSL);
    elseif Cl
        zc = CSLR & SSL;
    else
        zc = CSLR & SSR;
    end

    % Restore original shape
    if (sz(1) < sz(2))
        zc = zc';
    end

end