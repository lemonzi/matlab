function out = defaults(new, def)
% DEFAULTS (new, default)
% Copies missing fields in the new struct from defaults
% New can also be a cell array. In that case,
%    - if it's empty, defaults are returned
%    - if it has a single element, it's parsed as struct
%    - else, the elements are parsed as (field,value) pairs
% This is useful for parsing varargin without boilerplate

    if isstruct(new)
        out = new;
    elseif iscell(new)
        if numel(new) == 0
            out = def;
            return;
        elseif numel(new) == 1
            if iscell(new{1})
                out = new{1};
            else
                error('Cell with single element must contain a struct');
            end
        else
            out = cell2struct(new(2:2:end)', new(1:2:end));
        end
    else
        error('Input must be a struct or a cell array');
    end

    fields = fieldnames(def);

    for i = 1:numel(fields)
        if (~isfield(out, fields{i}))
            out.(fields{i}) = def.(fields{i});
        end
    end

end