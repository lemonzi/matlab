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

    % Toolbox fkmeans, fast k-means
    addpath(fullfile(mtpath, 'fkmeans'));

    % Toolbox aboxplot, advanced box plots
    addpath(fullfile(mtpath, 'aboxplot'));

    % Toolbox jsonlab, deals with json files
    addpath(fullfile(mtpath, 'jsonlab'));

    % Toolbox cloudPlot
    addpath(fullfile(mtpath, 'cloudPlot'));

    % Toolbox clinep, plot 3D lines with varying color
    addpath(fullfile(mtpath, 'clinep'));

    % Toolbox plotShaded, plot semi-transparent band between two lines
    addpath(fullfile(mtpath, 'plotShaded'));

    % Toolbox export_fig, export figures to eps and pdf
    addpath(fullfile(mtpath, 'export_fig'));

    % Toolbox yin, fundamental frequency estimator
    addpath(fullfile(mtpath, 'yin'));

    % Compiled libsvm binaries for various platforms (in progress)
    if strcmp(mexext,'mexmaci64')
        addpath(fullfile(mtpath, 'libsvm', 'maci64'));
    elseif strcmp(mexext, 'mexw32')
        addpath(fullfile(mtpath, 'libsvm', 'win32'));
    end
    
    % Nice plots (comment out if you want standard plotting)
    plotdefaults

end