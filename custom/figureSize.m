function h = figureSize(h,height)
% height by default

    if nargin == 1
        height = h;
        h = gcf;
    end

    if strcmp(height, 'fullpage')
        figureSize(h, [550, 700]);
        return;
    elseif strcmp(height, 'fullwidth')
        figureSize(h, 550);
        return;
    end

    pos = get(h, 'Position');

    if length(height) == 1
        pos(4) = height;
    else
        pos(3:4) = height;
    end

    set(h, 'Position', pos);

end