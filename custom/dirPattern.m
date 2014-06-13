function files = dirPattern(pat)
% Returns a cell array with the file names matching the pattern

    files = dir(pat);
    files = {files.name};

end
