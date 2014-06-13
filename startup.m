function startup()
% Adds the toolboxes from MATLABtools to the path.

    mtpath = fileparts(mfilename('fullpath'));

    % If can't find current path, assume we cd'ed to the folder
    if isempty(mtpath)
        mtpath = pwd();
    end

    % Add the toobox root, in case anything is thrown there
    addpath(mtpath);

    % Add the misc custom functions (this is the real magic)
    addpath(fullfile(mtpath, 'custom'));

    % Toolbox arrow.m, draws arrows
    addpath(fullfile(mtpath, 'arrow'));

    % Toolbox fkmeans.m, fast k-means
    addpath(fullfile(mtpath, 'fkmeans'));

    % Toolbox drawLA, draws linear algebra stuff
    addpath(fullfile(mtpath, 'drawLA'));

    % Toolbox jsonlab, deals with json files
    addpath(fullfile(mtpath, 'jsonlab'));

    % Compiled libsvm binaries for mac
    if strcmp(mexext,'mexmaci64')
        addpath(fullfile(mtpath, 'libsvm', 'maci64'));
    end

end