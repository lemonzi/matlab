function [suf, stripped] = suffix(varargin)
% Finds common suffix in a set of strings

    if (nargin > 1)
        strings = varargin;
    elseif (nargin == 1 && iscell(varargin{1}))
        strings = varargin{1};
    elseif (~iscell(varargin{1}))
        stripped = varargin(1);
        suf = '';
        return
    else
        stripped = {};
        suf = '';
        return
    end

    % Max length
    maxlen = max(cellfun(@length, strings));

    % Pad to the right for prefix
    names_mat = zeros(length(strings), maxlen);
    for i = 1:length(strings)
        len = length(strings{i});
        names_mat(i,:) = [repmat(i, 1, maxlen-len), strings{i}];
    end

    ref = names_mat(1,:);
    eqs = bsxfun(@eq, names_mat, ref);
    eqs = all(eqs, 1);
    split = find(eqs == 0, 1, 'last') + 1;
    if (isempty(split))
        split = 1;
    end
    suf = char(ref(split:end));

    if (nargout > 1)
        % Compute unprefixed versions of the strings
        stripped = strings;
        for i = 1:numel(strings)
            stripped{i} = strings{i}(1:end-(length(ref)-split+1));
        end
    end

end