function out = map(fun, data, varargin)
% MAP - functional utilities for MATLAB
%
% Generates a container by mapping each element in one or more containers
% with a given function. Accepts arrays (be it numeric, logical, or 
% struct), cell arrays, and sparse matrices as input, outputs an array if
% all outputs are scalar and a cell array otherwise.
%
% TODO: make it more clever and flexible when deciding the output format
%
% Quim Llimona, 2015

    if iscell(data)
        out = cellfun(fun, data, varargin{:}, 'UniformOutput', false);
    elseif issparse(data)
        out = spfun(fun, data, varargin{:}, 'UniformOutput', false);
    else
        out = arrayfun(fun, data, varargin{:}, 'UniformOutput', false);
    end
    
    if all(cellfun(@isscalar, out))
        out = cell2mat(out);
    end
    
end
