function out = pluck(s, varargin)
% out = pluck(s, field, [subfield], ..., [sub-sub-field])
%
% Extracts the specified field from a struct array.
% If more than one name is specified, the struct is assumed to be hierarchic.
% That is, each element of the struct array is a scalar struct itself.
%
% Quim Llimona, 2015
    
    N = length(varargin);

    if N < 1
        error('No field specified.');
    end

    out = s;
    for i = 1:N
        try
            out = arrayfun(@(x)[x.(varargin{i})], out);
        catch err1
            if strcmp(err1.identifier,'MATLAB:arrayfun:NotAScalarOutput')
                out = arrayfun(@(x)[x.(varargin{i})]', out, 'UniformOutput', false);
                try
                    out = cell2mat(out);
                catch err2
                    if ~strcmp(err2.identifier,'MATLAB:cell2mat:MixedDataTypes')
                        rethrow(err2);
                    end
                end
                out = out';
            else
                rethrow(err1);
            end
        end
    end
    
end
