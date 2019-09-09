function [R] = normcorr2D(t, A)
% normcorr2D takes a template t and a search region A, and lags t over A,
% calculating the normalised correlation at each lag. It outputs the
% normalised cross-correlation matrix.

[Ay, Ax] = size(A);  % Dimensions of A
[ty, tx] = size(t);  % Dimensions of t
A = padarray(A, [ty-1 tx-1], -1);  % Zero pads A
R = zeros(Ay + ty - 1, Ax + tx - 1);  % Preallocates memory 

% Calculates the mean and standard deviation of t - these are constant
% throughout the calculation.
tmean = sum(t, 'all')/numel(t);
tstd = (sum((t- tmean).^2, 'all'))^0.5;

% Lags t over A. Zero lag is taken to be when the upper left corners of
% t and A are coincident.
for lagy = -(ty-1):(Ay-1)
    for lagx = -(tx-1):(Ax-1)
        % Calculates the mean and standard deviation of the area under t
        undert = A(lagy+ty:lagy+2*ty-1, lagx+tx:lagx+2*tx-1);
        Amean = sum(undert, 'all')/numel(undert);
        Astd = (sum((undert - Amean).^2, 'all'))^0.5;
        if Astd ~= 0
            % Calculates the correlation
            R(lagy+ty, lagx+tx) = sum((undert - Amean).*(t - tmean), 'all')/(Astd*tstd);
        else
            % Defaults the correlation to zero if the area under t has zero
            % variance. This is how normxcorr2 operates
            R(lagy+ty, lagx+tx) = 0;
        end
    end
end

% Plots correlation vs. lag.
[X, Y] = meshgrid(-(tx-1):(Ax-1), -(ty-1):(Ay-1));
surf(X, Y, R) 
end

