function h = plotShaded(x, y, color, fstr, width)
% Plot a shaded regions with a line at the middle
% 
% x: x coordinates
% y: a 1xN, 2xN, or 3xN matrix of y-data
% color: a valid color spec (3D vector or string)
% fstr: format ('.-' or '--' etc)
% width: linewidth of the center plot
%
% example
% x=[-10:.1:10];plotshaded(x,[sin(x.*1.1)+1;sin(x*.9)-1],'r');

if size(y,1) > size(y,2)
    y = y';
end;

if nargin < 3
    color = niceColors(1);
end

if nargin < 4
    fstr = '-';
end

if nargin < 5
    width = 1;
end

if size(y,1) == 1
    % just plot one line
    h = plot(x,y,fstr);
elseif size(y,1) == 2
    % plot shaded area
    px=[x,fliplr(x)];
    py=[y(1,:), fliplr(y(2,:))];
    h = patch(px,py,1,'FaceColor',color,'EdgeColor','none');
    alpha(0.2);
elseif size(y,1) == 3
    % also draw mean
    px=[x,fliplr(x)];
    py=[y(1,:), fliplr(y(3,:))];
    h(2) = patch(px,py,1,'FaceColor',color,'EdgeColor','none');
    hold on
    h(1) = plot(x,y(2,:), fstr, 'Color', color, 'LineWidth', width, 'LineSmoothing', 'on');
    alpha(0.2),
elseif size(y,1) == 4
    % draw two areas
    px=[x,fliplr(x)];
    py1=[y(2,:), fliplr(y(3,:))];
    py2=[y(1,:), fliplr(y(4,:))];
    h(1) = patch(px,py1,1,'FaceColor',color,'EdgeColor','none');
    hold on
    h(2) = patch(px,py2,1,'FaceColor',color,'EdgeColor','none');
    alpha(h(1), 0.2);
    alpha(h(2), 0.0707);
elseif size(y,1) == 5
    % draw two areas with mean
    px=[x,fliplr(x)];
    py1=[y(2,:), fliplr(y(4,:))];
    py2=[y(1,:), fliplr(y(5,:))];
    h(2) = patch(px,py1,1,'FaceColor',color,'EdgeColor','none');
    hold on
    h(3) = patch(px,py2,1,'FaceColor',color,'EdgeColor','none');
    h(1) = plot(x,y(3,:), fstr, 'Color', color, 'LineWidth', width, 'LineSmoothing', 'on');
    alpha(h(2), 0.2);
    alpha(h(3), 0.0707);
end
