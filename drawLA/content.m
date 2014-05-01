%% Description
% The drawLA Toolbox was created to facilitate visualization of some basic
% concepts of Linear Algebra. It is a collection of MATLAB functions for easy
% plotting of 2D/3D vectors, planes, lines and spheres, and... displaying matrix
% equations.
%% Optional requirements
%  arrow.m         - draw a line with arrow head. Written by Erik Johnson.
%                    Available at the MATLAB Central File Exchange: File ID # 278.
%                    Required by drawAxes.m.
%% Toolbox content
% There are 12 functions in the toolbox. 
%
% 10 of them produce 2D/3D plots of geometric objects:
%
%  1.  drawVector.m  - Draw 2D/3D vector(s).
%  2.  drawPlane.m   - Draw 2D/3D plane.
%  3.  drawSpan.m    - Draw line(2D)/plane(3D) spanned by one (2D/3D) or two (3D) vectors.
%  4.  drawLine.m    - Draw 2D/3D line between two points.
%  5.  drawXLine.m   - Draw vertical line in xy-plane at given x value.
%  6.  drawYLine.m   - Draw horizontal line in xy-plane at given y value.
%  7.  drawCircle.m  - Draw circle(s) in a xy-plane plot.
%  8.  drawAxes.m    - Draw 2D/3D coordinate axes lines.
%  9.  drawSphere.m  - Draw unit 2D/3D sphere under a linear (affine) transformation.
%  10. drawMesh.m    - Plot a polygonal 2D/3D mesh.
%
% The other 2 are auxiliary functions for:
%
%  11. dispMEq     - Formatted display of a matrix equation.
%  12. drawGraph   - Draw small directed graph with up to 6 nodes.
%
% Each function is provided with a help and examples of its usage, which can be
% displayed by typing |help _function name_| in the command window. E.g., |help
% drawPlane|.

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>