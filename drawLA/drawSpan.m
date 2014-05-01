function varargout = drawSpan(V, pColor)
% Draw line(2D)/plane(3D) spanned by one (2D/3D) or two 3D vectors V.
%
% Usage: drawSpan(V)
%        hp = drawSpan(V)
%
% INPUT:
% V             - 3-by-{1,2} matrix of 3D column vectors, or
%                 2-by-1 2D vector.
% pColor        - string specifying plane color. 
%                 Default blue.
% OUTPUT:
% (optional)    - handle to the line or surface object.
%
% Examples:
% clf; drawSpan([1;1]);
% clf; drawSpan(rand(3,2)*2-1, 'r');
% clf; V = rand(3,2)*2-1; drawVector(V); hold on; drawSpan(V); hold off;
%
% See also: drawPlane, drawAxes, drawVector, drawVectorsc, drawLine.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

% Check input:
error(nargchk(1,2,nargin));
if isempty(V), return; end;
% Parse input: 
if numel(V)==2 || numel(V)==3, V = V(:); end
[dimV, numV] = size(V);
if (dimV - numV) <= 0
    error('Wrong input: number of input vectors must be less than their dimension');
end
% Defaults:
if nargin == 1, pColor = 'b'; end

switch dimV
    case 2
        V = V/norm(V);
        if isempty(get(gca, 'children')) % new plot?
            alpha = 1/max(V);
            hsp = drawLine([alpha*V, -alpha*V], pColor);
            drawAxes(dimV, 'k'); grid on;
        else
            lims = reshape(axis, 2,2);
            [ml ixl] = max(abs(lims));          % max-min lim for each coordintate
            [mc ixc] = max( ml );               % max-min coordinate
            alpha = lims(ixl(ixc),ixc)/V(ixc);
%             beta  = lims(ixl(mod(ixc,2)+1),ixc)/V(ixc);
%             if sign(beta)==sign(alpha), beta = -alpha*.1; end;
            beta = -alpha;
            hsp = drawLine([alpha*V, beta*V], pColor);
        end
    case 3
        if numV == 2                    % Draw plane
            n = cross(V(:,1),V(:,2));
            hsp = drawPlane(n,0,pColor);
        else                            % Draw line
           if isempty(get(gca, 'children')) % new plot?
               alpha = 1/max(V);
               hsp = drawLine([alpha*V, -alpha*V], pColor);
               view(3);
               drawAxes(dimV, 'k'); grid on;
               
           else
               axLims = axis;
               if length(axLims)~=6, view(3); end;
               lims = reshape(axis, 2, 3);
               [m ix] = max( max(abs(lims)) );
               alpha = m/V(ix);
               hsp = drawLine([alpha*V, -alpha*V], pColor);
           end
        
        end
    otherwise
        error('Wrong dimension of the input vectors.');
end
if nargout == 1, varargout{1} = hsp; end