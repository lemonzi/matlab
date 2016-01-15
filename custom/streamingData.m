function stream = streamingData(data, labels, index)
% Data should be Nstreams x Ndimensions x Npoints
% I like Npoints x Nstreams x Ndimensions better, I'll change it some day
% Labels is the name of each stream
% If data is a string, it is assumed to be a filename
% Then, labels{1} is the name of the data and labels{2} the name of the labels
% Returns handles for accessing data:
%   - getMatrix accepts label(s), range or (labels, range), and returns
%     a squeezed matrix with the result (this should be changed)
%   - getStruct takes the same but returns an array of structs
%   - filter returns a new Stream with the samples specified
%     logical and linear indexing are allowed
%   - setField returns a new Stream with an added (or updated) stream
%     only works when not reading directly from a file (for now)
%     obvioulsy, the new data should match sizes
%   - clear frees the memory (I think it doesn't work)
%   - labels is a list of all labels
%   - length is the number of points in the stream
%   - index is a struct that gives the underlying column index for a label

    if ischar(data)
        if nargin < 2
            labels = {'data', 'names'};
        end
        if exist('matfile', 'builtin')
            vars = matfile(data);
        else
            vars = load(data);
        end
        incrementalName = labels{1};
        labels = vars.(labels{2});
        npoints = size(vars.(incrementalName), 3);
        ndimensions = size(vars.(incrementalName), 2);
        access = @(x,y)(vars.(incrementalName)(x,1:ndimensions,y));
        accessAll = @()(vars.(incrementalName));
    else
        access = @(x,y)(data(x,:,y));
        accessAll = @()(data);
        npoints  = size(data, 3);
    end

    nstreams = numel(labels);

    if nargin > 2
        labelIndex = index;
    else
        labelIndex = cell2struct(num2cell(1:nstreams)', labels(:));
    end

    stream.getMatrix = @getMatrix;
    stream.getStruct = @getStruct;
    stream.filter    = @filter;
    stream.setField  = @setField;
    stream.clear     = @clearData;
    stream.labels    = labels;
    stream.length    = npoints;
    stream.index     = labelIndex;

    function dat = setField(name, contents)
        newData = data;
        newLabels = labels;
        if isfield(name, labelIndex)
            newData(labelIndex.(name), :, :) = contents;
        else
            newData(end+1, :, :) = contents;
            newLabels{end+1} = name;
        end
        dat = streamingData(newData, newLabels);
    end

    function filt = filter(ran)
        filt = streamingData(access(1:nstreams, ran), labels);
    end

    function clearData()
        clear('data', 'labelIndex', 'nstreams', 'npoints');
    end

    function [frames, names] = getMatrix(varargin)

        if nargin < 1
            frames = accessAll();
            names = labels;
            return
        end

        first = varargin{1};

        if isnumeric(first) || islogical(first)
            frames = access(1:nstreams, first);
            names = labels;
            return
        end

        if nargin > 1
            points = varargin{2};
        else
            points = 1:npoints;
        end

        if ischar(first)
            frames = squeeze(access(labelIndex.(first), points));
            names = {first};
        elseif iscell(first)
            indexes = cellfun(@(x)(labelIndex.(x)), first);
            frames = squeeze(access(indexes, points));
            names = first;
        else
            error('Input is not properly formatted.');
        end

    end

    function frames = getStruct(varargin)
        [stData, stLabels] = getMatrix(varargin{:});
        % Not sure if this is generic enough, but speeds up my computations a lot
        if length(stLabels) == 1
            cellData = {stData'};
        else
            cellData = num2cell(stData', 1);
        end
        % cellData = cellfun(@(x)(transpose(squeeze(x))), cellData, 'UniformOutput', true);
        frames = cell2struct(cellData(:), stLabels(:), 1)';
    end

end

