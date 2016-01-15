function [energy, medianEnergy, hop] = computeEnergy(s, L, hop)
% Compute mean and median squared energy over a sliding hann window
% Inputs:
%   - s: signal
%   - L: target window width in samples (will be rounded up if odd)
%   - overlap: target overlap (per one), rounded down if non-integer hop size
% Outputs:
%   - energy: energy signal
%   - hop: hop size, in samples

if mod( L,2 ) == 0
    L = L + 1;
end
w = window( @hann, L );
w = w ./ max( w );

if false
    hop = floor( L * (1-overlap) );
end
p = ceil( L/2 ) : hop : length( s ) - floor( L/2 );
N = length( p );
energy = zeros( N,1 );
if nargout > 1
    medianEnergy = zeros( N,1 );
end

for i = 1:N
    b = max( 1, p(i)-floor(L/2) );
    e = min( length(s), p(i)+floor(L/2) );
    sp = (s(b:e) .* w) .^ 2;
    if nargout > 1
        medianEnergy(i) = median(sp);
    end
    energy(i) = mean(sp);
end
