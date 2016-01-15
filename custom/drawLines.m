function h = drawLines(p1, p2, varargin)

    if nargin > 2 && isnumeric(varargin{1})
        params = varargin(2:end);
        figure(varargin{1});
    else
        params = varargin;
    end

    h = line([p1(1,:);p2(1,:)], [p1(2,:);p2(2,:)], [p1(3,:),p2(3,:)]);
    if (numel(params) == 1)
        set(h, 'Color', params{1});
    else
        set(h, params{:});
    end

end

