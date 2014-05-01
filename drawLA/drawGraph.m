function Graph = drawGraph(G)
% Draw small directed graph with up to 6 nodes
%
% Usage: drawGraph(G)
%        Graph = drawGraph(G)
%
% INPUT:
% G        - n-by-n graph adjacency matrix with "0" and "1" entries;
%            the diagonal elements of G should be all "0", i.e, no self links.
%
% OUTPUT:
% Graph    - Graph structure with the fields:
%            .G, .nodes, .node, .xy, .xy_delta, .nodelabel, .arrows
%
% Examples:
% G = [ 0 1 0; 1 0 1; 1 0 0] ; drawGraph(G);
% G = round(rand(7)); G=G-diag(diag(G)); drawGraph(G);
% 
% See also: drawPlane, drawAxes, drawVector, drawLine.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

% Check input:
error(nargchk(1,1,nargin));
[m,n] = size(G);
if m~=n, error('Adjacency matrix must be square.'); end;
if n>6,  error('The graph can have up to 6 nodes only.'); end

% Main
hf = gcf;
set(hf, 'color', 'w');
clf

nodes = { '\alpha', '\beta', '\gamma', '\delta', '\rho', '\sigma' } ;

xy = [
0 4
1 3
1 2
2 4
2 0
0 0
] ;

x = xy (:,1) ;
y = xy (:,2) ;

% scale x and y to be in the range 0.1 to 0.9
x = 0.8 * x / 2 + .1 ;
y = 0.8 * y / 4 + .1 ;
xy = [x y] ;

xy_delta = [
             .08   .04      0
            -.05   .08      0
             .04   0        0
            -.05   .04     -1
            -.03  -.05     -1
             .03  -.05      0
] ;

xd = xy_delta (:,1) ;
yd = xy_delta (:,2) ;
tjust = xy_delta (:,3) ;

clf

n = size (G,1) ;

axes ('Position', [0 0 1 1], 'Visible', 'off') ;

node = zeros (n,1) ;
nodelabel = zeros (n,1) ;
for k = 1:n
    node (k) = annotation ('ellipse', [x(k)-.025 y(k)-.025 .05 .05]) ;
    set (node (k), 'LineWidth', 2) ;
    set (node (k), 'FaceColor', [0 1 0]) ;
    nodelabel (k) = text (x (k) + xd (k), y (k) + yd (k), nodes {k}, ...
	'Units', 'normalized', 'FontSize', 16) ;
    if (tjust (k) < 0) 
	set (nodelabel (k), 'HorizontalAlignment', 'right') ;
    end
end


axis off

% Yes, I realize that this is overkill; arrows should be sparse.
% This example is not meant for large graphs.
arrows = zeros (n,n) ;

[i j] = find (G) ;
for k = 1:length (i)
    % get the center of the two nodes
    figx = [x(j(k)) x(i(k))] ;
    figy = [y(j(k)) y(i(k))] ;
%   [figx figy] = dsxy2figxy (gca, axx, axy);
    % shorten the arrows by s units at each end
    s = 0.03 ;
    len = sqrt (diff (figx)^2 + diff (figy)^2) ;
    fy (1) = diff (figy) * (s/len) + figy(1) ;
    fy (2) = diff (figy) * (1-s/len) + figy(1) ;
    fx (1) = diff (figx) * (s/len) + figx(1) ;
    fx (2) = diff (figx) * (1-s/len) + figx(1) ;
    arrows (i(k),j(k)) = annotation ('arrow', fx, fy) ;
    if G(j(k),j(k))~=0        % if dangling bond
        set( arrows(i(k),j(k)), 'Color', [.5 .5 .5]);
        set( arrows(i(k),j(k)), 'LineWidth', 1) ;
        set( arrows(i(k),j(k)), 'HeadLength', 10) ;
        set( arrows(i(k),j(k)), 'HeadWidth', 10) ;
        set( arrows(i(k),j(k)), 'LineStyle', '--')
    else
        set (arrows (i(k),j(k)), 'LineWidth', 2) ;
        set (arrows (i(k),j(k)), 'HeadLength', 20) ;
        set (arrows (i(k),j(k)), 'HeadWidth', 20) ;
    end
end

Graph.G = G ;
Graph.nodes = nodes ;
Graph.node = node ;
Graph.xy = xy ;
Graph.xy_delta = xy_delta ;
Graph.nodelabel = nodelabel ;
Graph.arrows = arrows ;
