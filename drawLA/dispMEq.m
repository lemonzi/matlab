function dispMEq(eq, varargin)
% Formatted display of a matrix equation
%
% Usage: dispEq(eq, arg)
%        dispEq(eq, arg1, arg2, ...)
%        dispEq(eq, arg1, arg2, ..., 'PropertyName', PropertyValue)
%
% INPUT:
% eq            - character string defining a matrix equation, e.g., 'A*x=b'
%                 allowed arithmetical operations are: [+, -, *, / , \, =, ;]
% arg{1,2,...}  - matrices corresponding to their symbolic definition in the equation,
%                 can be NaN (see the last 4 examples)
%
% (optional parameters)
% PropertyName:         PropertyValue
% 'format'      - a cell array with the formats for the text output. May be of 4 types:
%                 1) a string specifying the num2str conversion format,
%                    see help to num2str for details;
%                 2) 'elems' - output is symbolic, elementwise (default);                 
%                 3) 'cols'  - output is symbolic, grouped by colums;
%                 4) 'rows'  - output is symbolic, grouped by rows.
%
% OUTPUT:
% none
%
% Examples:
%  A = rand(5); figure(1);clf; dispMEq('A', A);
%  A = rand(5); figure(1);clf; dispMEq('A', A, 'format', {'%1.1f'});
%  A = randn(5,3); x=rand(3,1); figure(1); clf; dispMEq('A*x=b', A, x, A*x);
%  A = rand(5); [L,U]=lu(A); figure(1);clf; dispMEq('A=L*U',A,L,U);
%  A = nan(5); figure(1);clf; dispMEq('A',A);
%  A = nan(5); figure(1);clf; dispMEq('A',A,'format',{'cols'});
%  A = nan(3,2); B = nan(2,4); figure(1);clf; dispMEq('A*B',A,B,'format',{'rows','cols'});
%  y = {'\alpha' '\beta' '\gamma';'bla' 'bla' 'bla'}; figure(1);clf; dispMEq('y',y, 'format',{'rows'});
%
% See also: .

% Copyright (c) 2009, Dr. Vladimir Bondarenko <http://sites.google.com/site/bondsite>

% Check input:
error(nargchk(2,15,nargin));
if ~ischar(eq), error('The equation argument must be a string.'); end;

% Defaults:
global maxEntry minEntry
txtFormat = '%-5.2f';                   % Default text format

% Parse Input:
regexprep(eq, ' ', '');                 % remove white spaces
% ix  = regexp(eq, '[=,+,\-,*,\\,/,;]');   % find arithmetic operations
ix  = regexp(eq, '[=,+,\-,*,/,;]');   % find arithmetic operations
nOp = length(ix);
ix = [0 ix length(eq)+1];
if nargin<nOp+2, error('Number of numeric arguments is less then defined in the equation.');end;
for ii=1:nOp+1
    if ~isnumeric(varargin{ii})
        if iscell(varargin{ii})
            A(ii).data = nan(size(varargin{ii}));
            A(ii).max = nan;
            A(ii).min = nan;
            A(ii).userText = varargin{ii};
            A(ii).txtFormat = txtFormat;
            A(ii).m   = size(A(ii).data,1);
            A(ii).n   = size(A(ii).data,2);
            A(ii).symName = eq(ix(ii)+1:ix(ii+1)-1);
        else
            error('Error in the assignment of numeric arguments.');
        end
    else
        A(ii).data = varargin{ii};
        A(ii).max = max(A(ii).data(:));
        A(ii).min = min(A(ii).data(:));
        A(ii).m   = size(A(ii).data,1);
        A(ii).n   = size(A(ii).data,2);
        A(ii).symName = eq(ix(ii)+1:ix(ii+1)-1);
        A(ii).txtFormat = txtFormat;
        A(ii).userText = [];
    end
end
maxEntry = max([A(:).max]);
minEntry = min([A(:).min]);
% Parse optional arguments:
if nargin > nOp+2
    for ii=nOp+2:2:nargin-1
        switch lower(varargin{ii})
            case 'format'
                txtFormat = varargin{ii+1};
                if ~iscell(txtFormat), error('Format parameter must be a cell array.');end
                dum = length(txtFormat);
                if (dum>1)&&(dum~=nOp+1), error('Number of formats must either 1 or equal to the number of arguments.');end
                for jj=1:nOp+1
                    if ~isempty(txtFormat{ (dum>1)*jj + (dum==1) })
                        A(jj).txtFormat = txtFormat{(dum>1)*jj + (dum==1)};
                    end
                end
            otherwise
                error(['Unknown input parameter: ' varargin{ii}]);
        end
    end
end

% MAIN
sc = 3;                                 % column scaling factor for the subplots
dum1 = sum([A(:).n])*sc + nOp;          % overall number of subplots
dum2 = cumsum([A(:).n]*sc) + (0:nOp);   % overall number of columns

% Display matrices
for ii=1:nOp+1
    hsp(ii) = subplot(1,dum1,[(dum2(ii)-A(ii).n*sc+1) dum2(ii)]);
    if max(A(ii).m,A(ii).n)<=20             % Display text if max dimension does not exceed 20.
        dispMatrix(A(ii).data, A(ii).txtFormat);
        dispText(A(ii));
    else
        imagesc(A(ii).data(1:min(A(ii).m,30),1:min(A(ii).n,30)), [minEntry maxEntry]);
        axis equal tight off
        title(A(ii).symName, 'FontSize', 16);
    end
end

% Display arithmetic operations
for ii=1:nOp
    op = eq(ix(ii+1));
%     if strcmp(op, '*'), op='\times'; end;
    if strcmp(op, '*'), op='x'; end;
%     subplot(1,dum1, dum2(ii)+1);
    pos1 = get(hsp(ii)  , 'position');
    pos2 = get(hsp(ii+1), 'position');
    w = pos2(1)-(pos1(1)+pos1(3));
    h = pos1(4);
    subplot('position',[pos1(1)+pos1(3) pos1(2) w h])
    text(.3,.5,op, 'FontUnits', 'normalized', 'FontSize', 0.05);
    axis equal tight off
end
set(gcf, 'color', 'w');
end
%% Subfunctions:
%%
function dispMatrix(A,txtFormat)
% Plot matrix array to the current plot
global maxEntry minEntry

[m, n] = size(A);
if isnan(A)
    switch lower(txtFormat)
        case 'cols'
            dum = 1:n;
            A = dum(ones(m,1),:);
            minEntry = 0;
            maxEntry = n;
        case 'rows'
            dum = (1:m)';
            A = dum(:,ones(n,1));
            minEntry = 0;
            maxEntry = m;
        case 'elem'
            A = reshape(1:m*n, m, n);
            minEntry = 0;
            maxEntry = m*n;
        case 'user'
            A = nan(m,n);
        otherwise
    end
end
% Display matrix
if isnan(A), minEntry = 0; maxEntry = 1;end;
imagesc(A, [minEntry maxEntry]);
cmap = colormap(jet(128));
colormap(cmap(30:end-10,:));
axis equal tight
set(gca, 'XTick',[], 'YTick', []);
end
%%
function dispText(A)

[m, n] = size(A.data);
m1 = m; n1 = n;
% Convert matrix to string
if ~isempty(A.userText)
    txt = char(A.userText);
    fcolor = 'k';
else
    [txt, fcolor] = matrix2str(A.data, A.symName, A.txtFormat);
end

% Display text
title(A.symName, 'FontSize', 16);
axPos = get(gca, 'position');
[ii,jj] = meshgrid(1:n,1:m);
fsz = .45*max([axPos(3) axPos(4)])/max([m1 n1]);
ii = ii - .4*(m1/m);
jj = jj + .1;
text(ii(:),jj(:),txt, 'FontUnits', 'normalized',...
                      'FontSize', fsz,...
                      'Color', fcolor);
end
%%
function [txt,fcolor] = matrix2str(M,symName,txtFormat)
[m, n] = size(M);
[ii,jj] = meshgrid(1:n,1:m);
switch lower(txtFormat)
    case 'cols'
        if isscalar(M)==1
            txt = symName;      % No indices for 1-by-1 matrices, i.e., for scalars.
        else
            if n==1
                dum = lower(symName);
                txt = dum(ones(m,1),:);
            else
                txt = strcat(lower(symName), '_{', num2str(ii(:)), '}');
            end
            dum1 = ceil(m/2); dum2 = reshape(1:m*n,m,n);
            ix = dum2([1:dum1-1,dum1+1:end],:);
            txt(ix(:),:) = ' ';
        end
        fcolor = 'k';
    case 'rows'
         if isscalar(M)
            txt = symName;      % No indices for 1-by-1 matrices, i.e., for scalars.
         else
            if m==1
                dum = lower(symName);
                txt = dum(ones(n,1),:);
            else
                txt = strcat(lower(symName), '^{', num2str(jj(:)), '}');
            end
            dum1 = ceil(n/2); dum2 = reshape(1:m*n,m,n);
            ix = dum2(:,[1:dum1-1,dum1+1:end]);
            txt(ix(:),:) = ' ';
        end
        fcolor = 'k';
    otherwise
        if isnan(M)                 % Non-numeric input
            fcolor = 'w';
            if isscalar(M)
                txt = symName;      % No indices for 1-by-1 matrices, i.e., for scalars.
            else
                txt = strcat(symName, '_{', num2str(jj(:)), num2str(ii(:)), '}');
            end
        else                        % Numerical input
            fcolor = 'k';
            if abs(M-round(M))<realmin, txtFormat = '%-5.0f'; end % No fractional part for integers.
            txt = num2str(M(:), txtFormat);
        end

end
        
end             