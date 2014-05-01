function drawAxes(d, colr, labels)
% Draw 2D/3D axes lines through the origin.
%
% Usage: drawAxes(d, colr)
% INPUT:
% d         - number of dimensions: 2 or 3
% colr      - string defining axes lines color, e.g., 'k'
% labels    - cell array of strings with the axes names: 
%             e.g., {'\alpha', '\beta', '\gamma'}
%
% OUTPUT:
% none
%
% Examples: 
%  figure(1); clf; plot(exp(2*pi*i*[1:20]/20), '.'); drawAxes(2, 'k'); axis square;
%  figure(1); clf; plot(-50:49, rand(100,1)*100-50); drawAxes(2, 'k', {'Time', 'Energy'}); 
%  load('queen.mat'); figure(1); clf; drawMesh(vertex, face, 'wire'); drawAxes(3,'g');
%
% See also: drawVector, drawPlane, drawSpan, drawLine, drawMesh.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

% Check input:
error(nargchk(2,3,nargin));
% Parse: input
if nargin < 3, labels = {'x', 'y', 'z'}; end

% MAIN:
lims = axis;
lw = 1; % line width
if isempty(get(gca, 'userdata')); % check wether the axes is already drawn.
    set(gca, 'userdata', 1);
    ax = struct('line', {}, 'label', {}, 'labelxy', {});
    switch d
        case 2
            minlim1 = min( min( sort(lims(1:2)), 0 ) );
            maxlim1 = max( max( sort(lims(1:2)), 0 ) );
            minlim2 = min( min( sort(lims(3:4)), 0 ) );
            maxlim2 = max( max( sort(lims(3:4)), 0 ) );
            ax(1).line = [ minlim1 maxlim1; zeros(1,2) ];
            ax(2).line = [ zeros(1,2); minlim2 maxlim2];
            [ax.label] = deal(labels(1), labels(2));
            % Define coordinates for the axes labels
            dum = ax(1).line(:,2); ndum = norm(dum);
            ax(1).labelxy = dum + [-ndum*.1; -ndum*.1];
                        
            dum = ax(2).line(:,2); ndum = norm(dum);
            ax(2).labelxy = dum + [ndum*.05; -ndum*.05];
        case 3
            if length(lims)~=6, view(3); lims = axis; end % forse 3D axes
            minlim1 = min( min( sort(lims(1:2)), 0 ) );
            maxlim1 = max( max( sort(lims(1:2)), 0 ) );
            minlim2 = min( min( sort(lims(3:4)), 0 ) );
            maxlim2 = max( max( sort(lims(3:4)), 0 ) );          
            minlim3 = min( min( sort(lims(5:6)), 0 ) );
            maxlim3 = max( max( sort(lims(5:6)), 0 ) );                    
            ax(1).line = [ minlim1 maxlim1; zeros(1,2); zeros(1,2) ];
            ax(2).line = [ zeros(1,2); minlim2 maxlim2; zeros(1,2) ];
            ax(3).line = [ zeros(1,2); zeros(1,2); minlim3 maxlim3];
            [ax.label] = deal(labels(1),labels(2), labels(3));
            % Define coordinates for the axes labels
            fuc = .08;
            dum = ax(1).line(:,2); ndum = norm(dum);
            ax(1).labelxy = dum + [-ndum*fuc; ndum*fuc; -ndum*fuc];
            dum = ax(2).line(:,2); ndum = norm(dum);
            ax(2).labelxy = dum + [ndum*fuc; -ndum*fuc; -ndum*fuc];
            dum = ax(3).line(:,2); ndum = norm(dum);
            ax(3).labelxy = dum + [-ndum*fuc; ndum*fuc; -ndum*fuc];
        otherwise
            error('Incorrect input: must be 2 or 3');
    end
    % Capture the NextPlot property
    holdon = get(gca, 'NextPlot');
    hold on;
    for ii=1:d
        if d==2
            if exist('arrow.m','file')==2
                % save the curretn warning state and turn off all warning
                % to get rid of warnings in the arrow.m
                ws = warning('off', 'all'); 
                ha = arrow(ax(ii).line(:,1), ax(ii).line(:,2),...
                          'EdgeColor', colr, 'FaceColor', colr,... 
                          'LineWidth', lw                           );
                warning(ws); % restore the warning state
                axColor = get(ha, 'EdgeColor');
            else
                ha = line(ax(ii).line(1,:), ax(ii).line(2,:),... 
                          'color', colr, 'LineWidth', lw            );
                axColor = get(ha, 'Color');
            end
            tColor = .5*axColor;
            text(ax(ii).labelxy(1), ax(ii).labelxy(2), ax(ii).label,...
                                                      'FontSize', 16, ...
                                                      'Color'   , tColor            );
        else
            if exist('arrow.m', 'file')==2
                % save the curretn warning state and turn off all warning
                % to get rid of warnings in the arrow.m
                ws = warning('off', 'all');                 
                ha = arrow(ax(ii).line(:,1), ax(ii).line(:,2),...
                          'EdgeColor', colr, 'FaceColor', colr,...
                          'LineWidth', lw                           );
                warning(ws); % restore the warning state
                axColor = get(ha, 'EdgeColor');
            else
                ha = line(ax(ii).line(1,:), ax(ii).line(2,:),ax(ii).line(3,:),...
                     'color', colr, 'LineWidth', lw);
                axColor = get(ha, 'Color');
            end
            tColor = .5*axColor;
            text(ax(ii).labelxy(1), ax(ii).labelxy(2), ax(ii).labelxy(3), ...
                                                       ax(ii).label, ...
                                                       'FontSize'  , 18, ...
                                                       'Color'     , tColor          );
        end
    end
    set(gca, 'NextPlot', holdon); % restore the NextPlot property
end
axis equal tight 