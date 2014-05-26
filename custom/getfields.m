function x = getfields(st, fields, ranges, output)

    % No range specified means yield everything
    getall = nargin < 3 || isempty(ranges);
    if getall
        ranges = NaN; % just for safety, not really used
    end

    % Default output is cell
    if nargin < 4
        output = 'cell';
    end

    % Check whether the range is per item or global
    uniform = ~iscell(ranges);

    % Check if we are extracting a single field
    issingle = ~iscell(fields);
    if issingle
        fields = {fields};
    end

    % Vectorize data, in case we want multidimensional output
    vecfields = reshape(fields, [], 1);
    if ~getall && ~uniform
        vecranges = reshape(ranges, [], 1);
    end

    % Initialize output container
    vecx = cell(size(vecfields));

    for i = 1:numel(vecfields)

        % Get data
        field = vecfields{i};
        if ~getall && uniform
            ran = ranges;
        elseif ~getall && ~uniform
            ran = vecranges{i};
        end

        % Walk the struct
        if any(field == '.')
            fieldpath = strsplit(field,'.');
        else
            fieldpath = {field};
        end
        value = st;
        skiprange = false;
        while ~isempty(fieldpath)
            f = fieldpath{1};
            fieldpath = fieldpath(2:end);
            if f == '*'
                if getall
                    value = getfields(value, fieldnames(value), [], output);
                else
                    value = getfields(value, fieldnames(value), ran, output);
                end
                skiprange = true;
                break;
            else
                value = [value.(f)];
            end
        end

        % Filter the obtained data
        if ~getall && ~skiprange
            if isnumeric(ran)
                value = value(ran);
            else
                value = ran(value);
            end
        end

        % Save
        vecx{i} = value;

    end

    % Format the output
    if issingle
        x = vecx{1};
    elseif strcmp(output, 'cell')
        x = reshape(vecx, size(fields));
    elseif strcmp(output, 'struct')
        x = struct();
        for i = 1:numel(vecfields)
            x.(vecfields{i}) = vecx{i};
        end
    elseif strcmp(output, 'matrix')
        datasize = size(vecx{1});
        position = find(datasize == 1, 1);
        if isempty(position)
            offset = [ones(1,length(datasize)), numel(vecx)];
        elseif position == 1
            offset = [numel(vecx), 1];
        else
            offset = [ones(1,position-1), numel(vecx)];
        end
        x = cell2mat(reshape(vecx, offset));
    end

end
