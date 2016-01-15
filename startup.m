function startup()
% Adds the toolboxes from MATLABtools to the path.

    mtpath = fileparts(mfilename('fullpath'));

    % If can't find current path, assume we cd'ed to the folder
    if isempty(mtpath)
        mtpath = pwd();
    end

    add = @(varargin) addpath(fullfile(mtpath, varargin{:}));

    % Add the toobox root, in case anything is thrown there
    add('');

    % Add the misc custom functions (this is the real magic)
    add('custom');

    % Toolbox fkmeans, fast k-means
    add('fkmeans');

    % Toolbox aboxplot, advanced box plots
    add('aboxplot');

    % Toolbox jsonlab, deals with json files
    add('jsonlab');

    % Toolbox cloudPlot
    add('cloudPlot');

    % Toolbox clinep, plot 3D lines with varying color
    add('clinep');

    % Toolbox plotShaded, plot semi-transparent band between two lines
    add('plotShaded');

    % Toolbox export_fig, export figures to eps and pdf
    add('export_fig');

    % Toolbox yin, fundamental frequency estimator
    add('yin');

    % Toolbox subaxis, better subplot
    add('subaxis');

    % Toolbox progressbar, better waitbar
    add('progressbar');

    % Compiled libsvm binaries for various platforms (in progress)
    if strcmp(mexext,'mexmaci64')
        add('libsvm', 'maci64');
    elseif strcmp(mexext, 'mexw32')
        add('libsvm', 'win32');
    end

end
