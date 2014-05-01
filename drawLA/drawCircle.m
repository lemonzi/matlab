function drawCircle(varargin)
% Draw circle(s) in the xy-plane.
%
% Usage:    drawCircle
%           drawCircle(xc,yc,r)
%           drawCircle(xc,yc,r, 'lType')
%
% INPUT:
% (optional)
% xc,yc     - n-by-m matrices with (x,y) coordinates of the center(s) 
%             of n*m circles. Default: (0, 0).
% r         - either a scalar or an n-by-m matrix of circle(s) radii.
%             Default: 1.
% 'lType'  - a string defining the line style and width (e.g., '2r-.').
%             Default: 'b-'.
%
% OUTPUT:
% none
%
% Examples in 2D:
%  clf; drawCircle;
%  clf; drawCircle(3, 2, '2r-.');
%  clf; x = randn(2,3); y = randn(2,3); r = rand(2,3); drawCircle(x,y,r,'gs');
% Examples in 3D:
%  clf; drawVector([1 1 2]); hold on; drawCircle([0 1], [0 -1], [1,.5], '2r-'); hold off;
%
% See also: drawSphere, drawPlane, drawVector, drawLine, drawXLine, drawYLine.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

% Check input:
error(nargchk(0,4,nargin));

% Defaults:
N = 100; k = 0:N;       % Number of points on the circle(s)
xc = 0; yc = 0; r = 1;  % Center coordinates and radius.
lType = 'k-';

% Parse input:
for ii=1:nargin
    if ischar(varargin{ii})
        lType = varargin{ii};
    elseif isscalar(varargin{ii})
        if nargin==1 
            r = varargin{ii};
        elseif ii==1
            xc = varargin{ii};
        elseif ii==2
            yc = varargin{ii};
        end    
    else
        if ii==1
            xc = varargin{ii};
        elseif ii==2
            yc = varargin{ii};
        else
            r = varargin{ii};
        end
    end 
end
% Check input
if ~all(size(xc)==size(yc)), error('Dimensions of xc and yc must be equal.'); end;
if ~isscalar(r)&&~all(size(xc)==size(r))
    error('Wrong dimensions of r. Must be scalar or matrix with dimensins of xc and yc'); 
end;
% Parse the line parameters
[lStyle,lWidth,lColor, lMarker] = parseLineType(lType);
    
% MAIN:
holdon = get(gca, 'NextPlot'); % Capture the NextPlot property

for ii=1:size(xc,1)
    for jj = 1:size(xc,2)
        xy = r(ii,jj)*exp(2*pi*1i*k./N) + xc(ii,jj) + 1i*yc(ii,jj);
        x = real(xy); y = imag(xy);
        line(x, y, 'LineStyle', lStyle, ...
                   'LineWidth', lWidth, ...
                   'Color'    , lColor, ...
                   'Marker'   , lMarker     );

        hold on;
    end
end
axis equal
set(gca, 'NextPlot', holdon); % restore the NextPlot property

function [lStyle,lWidth,lColor, lMarker] = parseLineType(lType)
% Parse the line type
% get line style
lStyles = '--|:|-\.|-';
[dum1,dum2,dum3, lStyle] = regexp(lType, lStyles, 'once');
if isempty(lStyle), lStyle = 'none'; end
% get width
[dum1,dum2,dum3, lWidth] = regexp(lType, '\d*', 'once');
if isempty(lWidth), lWidth = 1; else lWidth = str2double(lWidth); end
% get color
lColors = 'y|m|c|r|g|b|w|k';
[dum1,dum2,dum3, lColor] = regexp(lType, lColors, 'once');
if isempty(lColor), lColor = 'k'; end
% get marker
lMarkers = '\+|o|\*|\.|x|s|d|\^|>|<|v|p|h|';
[dum1,dum2,dum3, lMarker] = regexp(lType, lMarkers, 'once');
if isempty(lMarker), lMarker = 'none'; end