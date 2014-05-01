function varargout = drawLine(Points, lType)
% Draw 2D/3D line between two points.
%
% Usage: drawLine(Points)
%        drawLine(Points, lType)
%        hLine = drawLine(Points, lType)
%
% INPUT:
% Points        - {2,3}-by-2 matrix with 2D/3D coordinates on 2 points.
% (optional parameters)
% lType         - string specifying line color, style and width, and
%                 the marker, e.g., 'r2--*'.
%                 Default: 'k1--' (no marker);
%
% OUTPUT:
% (optional output): handle to the line object.
%
% Examples:
% V = rand(2,2)*2-1; drawVector(V); drawLine(V);
% V = rand(2,2)*2-1; drawVector(V); drawLine(V, '2-.');
% V = rand(3,2)*2-1; drawVector(V); drawLine(V);
%
% See also: drawVector, drawPlane, drawSpan, drawMesh.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

% Check input for sanity:
error(nargchk(1,2,nargin));
error(nargoutchk(0,1,nargout));
% Parse the input:
if nargin==1 
    lColor = 'k'; lStyle = '--'; lWidth = 1; lMarker = 'none';
else
    if ~ischar(lType), error('Wrong input: lType must be a string.');end
    % Parse the lType string
    % get line style
    lStyles = '--|:|-\.|-';
    [dum1,dum2,dum3, lStyle] = regexp(lType, lStyles, 'once');
    if isempty(lStyle), lStyle = '--'; end
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
end

% Plot the line
dim = size(Points,1);
switch dim
    case 2
        xData = Points(1,:);
        yData = Points(2,:);
        hLine = line(xData, yData, 'LineStyle', lStyle, ...
                                   'LineWidth', lWidth, ...
                                   'Color'    , lColor, ...
                                   'Marker'   , lMarker     );
    case 3
        xData = Points(1,:);
        yData = Points(2,:);
        zData = Points(3,:);
        hLine = line(xData, yData, zData, ...
                                   'LineStyle', lStyle, ...
                                   'LineWidth', lWidth, ...
                                   'Color'    , lColor, ...
                                   'Marker'   , lMarker     );
    otherwise
        error('Wrong dimensions of the input parameter.');
end
if nargout, varargout{1} = hLine; end
    