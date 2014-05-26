function out = defaults(new, def)
% DEFAULTS (new, default)
% Copies missing fields in the new struct from defaults
% New can also be a cell array. In that case,
%    - if it's empty, defaults are returned
%    - if it has a single element, defaults is called again with that element
%    - else, the elements are parsed as (field,value) pairs
% This is useful for parsing varargin without any boilerplate

    % Super-fancy parser that eats anything
    if isstruct(new)
        out = new;
    elseif iscell(new)
        if numel(new) == 0
            out = def;
            return;
        elseif numel(new) == 1
            out = defaults(new{1}, def);
            return;
        else
            out = cell2struct(new(2:2:end)', new(1:2:end)');
        end
    else
        error('Input is not properly formatted.');
    end

    fields = fieldnames(def);

    for i = 1:numel(fields)
        if (~isfield(out, fields{i}))
            out.(fields{i}) = def.(fields{i});
        end
    end

end
