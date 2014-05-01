function varargout = drawYLine(y, lType)
% Draw horizontal line in xy-plane at given y.
%
% Usage: drawYLine(y)
%        drawYLine(y, lType)
%        hLine = drawYLine(y, lType)
%
% INPUT:
% y             - scalar value of y.
% (optional parameters)
% lType         - string specifying line color, style and width, and
%                 the marker, e.g., 'r2--*'.
%                 Default: 'k1--' (no marker);
%
% OUTPUT:
% (optional output): handle to the line object.
%
% Examples in 2D:
%  clf; drawVector([1 1]); hold on; drawYLine(1); hold off;
%  clf; drawCircle(0,0,1); hold on; drawYLine(.5); hold off;
% Example in 3D:
%  clf; drawVector([1 1 1]); hold on; drawYLine(1, '2r-.'); hold off;
%
% See also: drawXLine, drawVector, drawPlane, drawSpan, drawMesh, drawCircle.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

% Check input for sanity:
error(nargchk(1,2,nargin));
error(nargoutchk(0,1,nargout));

% Defaults:
if nargin==1, lType = 'k1--'; end

% MAIN:
xlims = xlim;
hLine = drawLine([xlims; y y], lType);

if nargout, varargout{1} = hLine; end