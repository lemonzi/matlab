function out = defaults(new, def)
% DEFAULTS
% Copies missing fields in the new struct from defaults

    out = new;
    fields = fieldnames(def);

    for i = 1:numel(fields)
        if (~isfield(new, fields{i}))
            out.(fields{i}) = def.(fields{i});
        end
    end

end