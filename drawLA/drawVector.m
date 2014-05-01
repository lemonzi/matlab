function hV = drawVector(V, varargin)
% plot 2D/3D vector
%
% Usage: drawVector(v)
%        drawVector(..., markerType)
%        drwaVector(..., labels)
%        drwaVector(..., 'AxesLabels', axLabels)
%
% INPUT:
% v             - 2(3)-by-n matrix of 2D(3D) dimensional vectors;
% (optional)
% markerType    - string defining type of the marker and style of the line 
%                 e.g., 'rs--' (default 'bo-');
% labels        - cell array of strings defining vector labels, 
%                 e.g, {'a', 'b'}. Default: none;
% 'AxesLabels'/  
%  axLabels     - cell array of strings defining axes names, 
%                 e.g., {'\alpha', '\beta', '\gamma'}.
%                 Default: {'x', 'y', 'z'}.
% OUTPUT:
% (optional)
% hV            - handle structure, containing the handles to: the vector
%                 hV.p  - vector points (markers),
%                 hV.l  - vector lines,
%                 hV.t  - vector labels (text).
%
% Examples:
% drawVector([1 1]);
% drawVector([1 2 5], 'r>--');
% drawVector(rand(2,5)*2-1, 'r-');
% drawVector(rand(3,4)*2-1, 'sg-', {'1','2','3','4'});
% drawVector(rand(3,3)*2 -1, 'AxesLabels', {'\alpha', '\beta', '\gamma'});
% drawVector(rand(3,3)*2 -1, 'go', {'a','b', 'c'});
% hV = drawVector(rand(2,5)*2-1, 'rs-.', {'1','2','3','4','6'}); 
%      set(hV.t(5), 'string', '5');
%
% See also: drawPlane, drawSpan, drawLine, drawMesh, drawAxes.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

error(nargchk(1,5,nargin));
% Defaults
mType = 'bo-';
labels = [];
axLabels = {'x', 'y', 'z'};
% Parse input
if ~isreal(V)
    V = [real(V); imag(V)];
end

k = -1;
if nargin>1
    for ii=1:nargin-1
        if ii == k
            continue;
        end
        if ischar(varargin{ii})
            if strcmpi(varargin{ii}, 'AxesLabels')
                axLabels = varargin{ii+1};
                k = ii+1;               
            else
                mType = varargin{ii};
            end
        elseif iscell(varargin{ii})
            labels = varargin{ii};
        else
            error(['Uknown input argument: ' varargin{ii}]);
        end
    end
end
% Parse the mType parameter
% get the line style
lStyles = '--|:|-\.|-';
[dum1,dum2,dum3, lStyle] = regexp(mType, lStyles, 'once');
% get color
pColors = 'y|m|c|r|g|b|w|k';
[dum1,dum2,dum3, pColor] = regexp(mType, pColors, 'once');
if isempty(pColor), pColor = 'b'; end;
% get marker
pMarkers = '\+|o|\*|\.|x|s|d|\^|>|<|v|p|h|';
[dum1,dum2,dum3, pMarker] = regexp(mType, pMarkers, 'once');
if isempty(pMarker), pMarker = pColor; end

holdon = get(gca, 'NextPlot'); % Capture the NextPlot property
if (numel(V)==2)||(numel(V)==3)
    V = V(:);    % make input to column vector
end
ncols = size(V,2);  % number of vectors

% Draw vectors
for ii=1:ncols
    v = V(:,ii);
    d = length(v);
    v0 = [zeros(size(v)) v]; % form vector from origin
    switch d
        case 2
            hV.p(ii)=plot(v(1), v(2), pMarker, 'Color', pColor,...
                                         'MarkerFaceColor', pColor); 
            hold on;
%             colr = get(hp, 'color');
%             set(hp, 'MarkerFaceColor', colr);
            if ~isempty(lStyle)
                hV.l(ii) = line(v0(1,:), v0(2,:), 'color', pColor,...
                                            'LineStyle', lStyle,...
                                            'LineWidth', 2);
            end
            if ~isempty(labels)
                lColor = get(hV.p(ii), 'color');
                tColor = lColor*.5;
                hV.t(ii) = text(v(1)*1.1, v(2)*.9, labels{ii}, ...
                                        'FontSize'  , 16, ...
                                        'Color'     , tColor      );
            end
        case 3
            hV.p(ii)=plot3(v(1), v(2), v(3), pMarker, 'Color', pColor,...
                                                'MarkerFaceColor', pColor); 
            hold on;
%             colr = get(hp, 'color');
%             set(hp, 'MarkerFaceColor', colr);
            if ~isempty(lStyle)
                hV.l(ii) = line(v0(1,:), v0(2,:), v0(3,:), 'color', pColor,...
                                                     'LineStyle', lStyle,...   
                                                     'LineWidth', 2);
            end
            if ~isempty(labels)
                lColor = get(hV.p(ii), 'color');
%                 tColor = lColor + circshift(lColor, [0 1]);
                tColor = lColor*.5;
                hV.t(ii) = text(v(1)*1.1, v(2)*.9, v(3)*.9, labels{ii}, ...
                                                 'FontSize' , 16, ...
                                                 'Color'    , tColor       );
            end
        otherwise
            error('Input error: only 2D/3D vectors can be ploted');
    end
    hold on
end
% Adjust figure scale
box(1:2:2*d-1) = -1; % -1-by-1 box 
box(2:2:2*d) = 1;
maxLength = sqrt(max(diag(V'*V)));
box = box*maxLength;
axis(box); axis square;
grid on
drawAxes(d, 'k', axLabels)
set(gca, 'NextPlot', holdon); % restore the NextPlot property