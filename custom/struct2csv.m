function struct2csv(filename, data, header)

    labels = fieldnames(data);
    raw = struct2cell(data(:));

    fd = fopen(filename, 'w');

    if fd == -1
        error(['Could not open ' filename ' for writing.']);
    end

    if nargin < 3 || header
        fprintf(fd, '%s\n', strjoin(labels, ', '));
    end

    for i = 1:size(raw, 2)
        fprintf(fd, '%s\n', strjoin(raw(:,i), ', '));
    end

    fclose(fd);

end

