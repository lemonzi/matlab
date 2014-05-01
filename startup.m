function startup()
% Adds the toolboxes from MATLABtools to the path.

    mtpath = fileparts(mfilename('fullpath'));

    % If can't find current path, assume we cd'ed to the folder
    if isempty(mtpath)
        mtpath = pwd();
    end

    % Add the toobox root, wich various functions
    addpath(mtpath);

    % Toolbox arrow.m, draws arrows
    addpath(fullfile(mtpath, 'arrow'));

    % Toolbox drawLA, draws linear algebra stuff
    addpath(fullfile(mtpath, 'drawLA'));

    % Toolbox jsonlab, works with json files
    addpath(fullfile(mtpath, 'jsonlab'));

    % Compiled libsvm binaries for mac
    if strcmp(mexext,'mexmaci64')
        addpath(fullfile(mtpath, 'libsvm'));
    end

end