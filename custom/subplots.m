function h = subplots(n, ratio)
% SUBPLOTS - Automatically create a layout with N subplots
%
% Generate a list of N axes nicely laid out as subplots.
% It always prefers to have more columns than rows.
%
% n: number of axes to create
% ratio: aspect ratio of the figure (we take the current on by default)
%
% Quim Llimona, 2015

    if nargin < 2
        sz = get(gcf, 'Position');
        ratio = sz(3) / sz(4);
    end

    cols = ceil(sqrt(n * ratio));
    rows = floor(sqrt(n / ratio));
    
    while cols * rows < n
        rows = rows + 1;
    end
    
    h = zeros(n, 1);
    for i = 1:n
        h(i) = subplot(rows, cols, i);
    end
    
end

