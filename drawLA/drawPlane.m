function varargout = drawPlane(n, varargin)
% plot 2D/3D plane
%
% Usage: drawPlane(v)
%        drawPlane(v, shift)
%        drawPlane(v, shift, color)
%        hp = drawPlane(v, ...)
%
% INPUT:
% n             - 2D(3D) dimensional normal vector.
% (optional)
% shift         - scalar, defines the plane shift;
% color         - string, specifying plane color;
% OUTPUT:
% (optional)    - handle to the surface object.
%
% Examples:
% drawPlane([1 1]);
% drawPlane([1 2 5]);
% drawPlane([1 2 5], 1);
% drawPlane([1 2 5], 1, 'r');
%
% See also: drawAxes, drawVector, drawLine, drawSpan, drawMesh.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

% Check input:
error(nargchk(1,3,nargin));
% Defaults:
color = 'b'; shift = 0; alfa = .5;
% Parse input:
n = n(:);
if nargin > 1
    for ii=1:nargin-1
        switch logical(true)
            case isnumeric(varargin{ii})
                shift = varargin{ii};
            case ischar(varargin{ii})
                color = varargin{ii};
        end
    end
end
            
% ____________________________
[dum, ix] = sort(abs(n), 'ascend'); % independent variable is the one with 
                                    % largest component of the normal vector                                    vector
dimV = size(n,1); % dim of the input-vector
if dimV==1 || dimV > 3, error('Wrong dimension of the normal vector');end

% Draw the plane surface
holdon = get(gca, 'NextPlot'); % Capture the NextPlot property
switch dimV
    case 2
        if isempty(get(gca, 'children')) % new plot?
            v(:,ix(1)) = (-1:1)';
        else
            lims = reshape(axis, 2,2);
            v(:,ix(1)) = lims(:,ix(1));
        end
        v(:,ix(2)) = ( shift - n(ix(1))*v(:,ix(1)) )/n(ix(2));
        plot(v(:,1), v(:,2), color);
    case 3
        if isempty(get(gca, 'children')) % new plot?
            [v(:,:,ix(1)), v(:,:,ix(2))] = meshgrid(-1:2:1);
        else
            lims = reshape(axis, 2,3);
            [v(:,:,ix(1)), v(:,:,ix(2))] = meshgrid([lims(:,ix(1)), lims(:,ix(1))], ...
                                                    [lims(:,ix(2)), lims(:,ix(2))]);
            alfa = .1;
        end
        v(:,:,ix(3)) = ( shift - n(ix(1))*v(:,:,ix(1)) - n(ix(2))*v(:,:,ix(2)) )/n(ix(3));
        hs = surf( v(:,:,1), v(:,:,2), v(:,:,3), 'FaceColor', color, ...
                                                 'EdgeColor', color,   ...
                                                 'LineWidth', 2             );
        set(gca, 'AlimMode', 'manual'); 
        set(hs, 'FaceAlpha', alfa);
end
if nargout == 1, varargout{1} = hs; end
axis square
drawAxes(dimV, 'k')
grid on
set(gca, 'NextPlot', holdon); % restore the NextPlot property
end