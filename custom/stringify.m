function out = stringify(in)
% Stringify a scalar number or logical. 
% Strings are left unchanged

    if isnumeric(in)
        out = num2str(in);
    elseif islogical(in)
        out = num2str(double(in));
    else
        out = in;
    end
    
end