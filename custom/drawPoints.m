function h = drawPoints(X, varargin)

    if nargin > 1 && isnumeric(varargin{1})
        params = varargin(2:end);
        figure(varargin{1});
    else
        params = varargin;
    end

    h = plot3(X(1,:),X(2,:),X(3,:), params{:});

end