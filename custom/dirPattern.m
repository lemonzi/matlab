function files = dirPattern(pat, varargin)
% Returns a cell array with the file names matching the pattern

    def.recursive = false;
    def.path      = 'relative';

    [folder, name, ext] = fileparts(pat);

    files = dir(pat);
    files = {files.name}';

end
