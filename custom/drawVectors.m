function h = drawVectors(orig, direc, varargin)

    if nargin > 2 && isnumeric(varargin{1})
        params = varargin(2:end);
        figure(varargin{1});
    else
        params = varargin;
    end

    if size(orig, 2) == 1 && size(direc, 2) ~= 1
        orig = repmat(orig, [1,size(direc,2)]);
    end

    h = quiver3(orig(1,:), orig(2,:), orig(3,:), direc(1,:), direc(2,:), direc(3,:));
    if (numel(params) == 1)
        set(h, 'Color', params{1});
    else
        set(h, params{:});
    end

end

