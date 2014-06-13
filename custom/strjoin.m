function out = strjoin(str, sep)

    if ischar(str)
        str = {str};
    end

    out = str{1};
    if isnumeric(out)
        out = num2str(out);
    end

    if length(str) > 1
        for s = 2:length(str)
            s_dec = str{s};
            if isnumeric(s_dec)
                s_dec = num2str(s_dec);
            end
            out = [out sep s_dec];
        end
    end

end