function y = flatten(x)
% flatten(x)
% Returns a 1D version of the input
% Equivalent to x(:)

    y = reshape(x,[],1);

end