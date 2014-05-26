function y = intlog(x)
% INTLOG(x)
% Signed logarithm of the absolute value of x
% Useful for comparing things in log scale

    y = sign(x) .* log(abs(x));

end