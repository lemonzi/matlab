function varargout = drawSphere(varargin)
% Draw unit 2D/3D sphere under a linear (affine) transformation.
%
% Usage: drawSphere;
%        x = drawSphere(A);
%        x = drawSphere(A, xc);
%        x = drawSphere(..., colr);
%        x = drawSphere(..., alfa);
%        x = drawSphere(..., N);
%
% INPUT (optional):
% A        - a 2-by-2 or 3-by-3 transformation matrix.
%            Default eye(3).
% xc       - a 2- or 3-shift vector.
% N        - integer \gt 2, defining the discretization of the sphere.
%            Default: 2D case - 100;
%                     3D case - 20 (input for the sphere() command).
% alfa     - transparency value in [0 1].
%            Default .5.
% colr     - a character, defining the sphere color.         
%            Default 'b'.
%
% OUTPUT (optional):
% 2D case: x    - 2-by-n matrix with [x; y] coordinates 
%                 of n points on the circle.
% 3D case: x    - 3-by-(n+1)^2 matrix with [x; y; z] coordinates 
%                 of (n+1)^2 points on the sphere (see the sphere() command).
%
% Examples:
% 2D:
%  clf; drawSphere(eye(2));
%  clf; drawSphere(magic(2), [6; 5], 'r');
%  clf; drawSphere(magic(2), [6; 5], 0);
% 3D:
%  clf; drawSphere;
%  clf; drawSphere('g', .7);
%  clf; A = magic(3); drawSphere(A, 'r', .8);
%  clf; drawSphere(rand(3), 'g', [5 1 1]);
%
% See also: sphere, drawPlane, drawVector, drawLine.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

% Input check:
error(nargchk(0,5,nargin));
error(nargoutchk(0,1,nargout));
% Defaults:
colr = 'b'; alfa = .5; A = []; xc = []; N = [];
% Parse Input:
for ii=1:nargin
    switch logical(true)
        case ischar(varargin{ii})
            colr = varargin{ii};
        case isscalar(varargin{ii})
            if varargin{ii}<=1
                alfa = varargin{ii};
            else
                N = varargin{ii};
            end
        case isvector(varargin{ii})
            xc = varargin{ii}; xc = xc(:);
        case isnumeric(varargin{ii}) && ~isscalar(varargin{ii}) && ~isvector(varargin{ii})
            A = varargin{ii};
    end
end
% Default A and xc
if isempty(A)&&isempty(xc)
    A = eye(3); xc = zeros(3,1);
elseif isempty(A)
    n = length(xc); A = eye(n);
elseif isempty(xc)
    [m,n] = size(A); xc = zeros(n,1);
end
[m,n] = size(A);
if (m~=n)||n>3||m>3, error('Matrix must be square: 2-by-2 or 3-by-3.'); end;
if length(xc)~=n, error('Dimensions of A and xc do not agree.'); end;

% MAIN:
holdon = get(gca, 'NextPlot'); % Capture the NextPlot property

switch n
    case 2
        % Default n
        if isempty(N), N = 100; end;
        k = 0:N;
        xy = exp(1i*2*pi*k./N);
        X = [real(xy); imag(xy)];
        Y = A*X;
%         line(Y(1,:)+xc(1),Y(2,:)+xc(2),'Color', colr);
        patch(Y(1,:)+xc(1), Y(2,:)+xc(2), colr,...
                                          'EdgeColor', colr,...  
                                          'FaceAlpha', alfa  );
        
    case 3
        if isempty(N), N = 20; end;
        [x y z] = sphere(N);
        X = [ x(:)'; y(:)'; z(:)' ];
        Y = A*X;
        surf(reshape(Y(1,:), size(x))+xc(1),...
             reshape(Y(2,:), size(y))+xc(2),...
             reshape(Y(3,:), size(z))+xc(3),...
             'facecolor', colr, 'facealpha', alfa)
end
if isempty(get(gca,'UserData')), drawAxes(n,'k');end
axis equal
set(gca, 'NextPlot', holdon); % restore the NextPlot property

% Output
if nargout==1, varargout{1} = Y; end;