function varargout = drawXLine(x, lType)
% Draw vertical line in xy-plane at given x value.
%
% Usage: drawXLine(y)
%        drawXLine(y, lType)
%        hLine = drawXLine(y, lType)
%
% INPUT:
% x             - scalar value of x.
% (optional parameters)
% lType         - string specifying line color, style and width, and
%                 the marker, e.g., 'r2--*'.
%                 Default: 'k1--' (no marker);
%
% OUTPUT:
% (optional output): handle to the line object.
%
% Examples in 2D:
%  clf; drawVector([1 1]); hold on; drawXLine(1); hold off;
%  clf; drawCircle(0,0,1); hold on; drawXLine(.5); hold off;
% Example in 3D:
%  clf; drawVector([1 1 1]); hold on; drawXLine(1, '2r-.'); hold off;
%
% See also: drawYLine, drawVector, drawPlane, drawSpan, drawMesh, drawCircle.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

% Check input:
error(nargchk(1,2,nargin));
error(nargoutchk(0,1,nargout));

% Defaults:
if nargin==1, lType = 'k1--'; end

% MAIN:
ylims = ylim;
hLine = drawLine([x x; ylims], lType);

if nargout, varargout{1} = hLine; end
