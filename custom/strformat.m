function out = strformat(format, data)
% STRFORMAT(format, data)
% Python-like string formatting, with named fields support.
%
% strformat('{who}'s car is {color}', struct('who','Quim','color','red');
%
% Quim Llimona, 2015

    out = format;

    if nargin < 2
        return
    end

    fields = fieldnames(data);
    for f = 1:length(fields)
        parts = strsplit(out, ['{' fields{f} '}']);
        out = strjoin(parts, stringify(data.(fields{f})));
    end

end

