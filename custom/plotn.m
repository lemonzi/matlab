function h = plotn(data, range, varargin)
% h = plotn(data, [range], [plot_options])
%
% Plot the given signal with a custom x-axis scale that starts at range(1) and
% ends at range(2), or between [0,1] by default.
% This allows easy aligment of signals with different sample rate.
%
% Quim Llimona, 2015

    if nargin < 2 || isempty(range)
        range = [0,1];
    end

    if ischar(range)
        varargin = [range, varargin];
        range = [0,1];
    end

    x = linspace(range(1), range(2), length(data));
    hh = plot(x, data, varargin{:});

    % Avoid assigning to `ans` if no output is provided
    if nargout > 0
        h = hh;
    end

end

