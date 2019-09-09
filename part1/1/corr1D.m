function [corr, lags] = corr1D(v1,v2)
% corr1D takes two vectors of the same size, v1 and v2, and lags v2 over
% v1 to create a correlation vector.

[~, len] = size(v1);
corr = zeros(1, 2*len - 1); % Preallocates memory

% Preprocesses v1 and v2 so that the for loop only involves element-wise
% multiplication.
v1mean = sum(v1)/len;
v2mean = sum(v2)/len;
v1scaled = v1 - v1mean;
v2scaled = v2 - v2mean;

% Zero pads v1 so that v2 can be lagged across it.
v1padded = [zeros(1,len-1) v1scaled zeros(1,len-1)];

% Calculates the correlation vector. Each loop calculates the correlation
% at a particular lag
for lag = -(len-1):(len-1)
    products = v1padded(lag+len:lag+2*len-1).*v2scaled;
    corr(lag+len) = sum(products)/len;
end

% Plots correlation vs. lag.
lags = -(len-1):(len-1);
plot(lags, corr)

end