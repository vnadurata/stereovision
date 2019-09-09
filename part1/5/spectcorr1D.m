function [corr, lags] = spectcorr1D(v1,v2)
% spectcorr1D takes two vectors of the same size and lags v2 over v1 to
% create a normalised correlation vector using a Fourier transform
% algorithm.

[~, len] = size(v1);
corr = zeros(1, 2*len - 1);  % Preallocates memory

% Preprocesses v1 and v2.
v1mean = sum(v1)/len;
v2mean = sum(v2)/len;
v1std = (sum((v1 - v1mean).^2)/len)^0.5;
v2std = (sum((v2 - v2mean).^2)/len)^0.5;
v1scaled = (v1 - v1mean)/v1std;
v2scaled = (v2 - v2mean)/v2std;

% Zero pads v1 and v2 appropriately for the Fourier transform algorithm.
v1padded = [zeros(1, 2*(len-1)) v1scaled];
v2padded = [zeros(1, len-1) v2scaled zeros(1, len-1)];

% Calculates the correlation
fullcorr = ifft(conj(fft(v2padded)).*fft(v1padded))/len;
corr = fullcorr(1:(2*len-1));  % Cuts out the irrelevant indices

% Plots correlation vs. lag
lags = -(len-1):(len-1);
plot(lags, corr)
end
