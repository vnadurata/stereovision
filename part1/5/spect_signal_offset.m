% Calculates the distance between two speakers by finding the lag between
% their signals using cross correlation.

tic

% Reads the data in.
sensor1 = readmatrix('sensor1_data.txt')';
sensor2 = readmatrix('sensor2_data.txt')';

% Calculates the normalised cross correlation.
corrvec = spectcorr1D(sensor1,sensor2); 

% Finds where the maximum correlation is.
[~, index] = max(corrvec);

% Converts the index of the maximum correlation to the distance between
% the two sensors and prints the result.
[~, len] = size(sensor1);
offset = abs((index - len)/44000);
dist = offset*333;
time = toc;
fasterby = 484.5/time;
fprintf('The offset is %.4f seconds.\n', offset)
fprintf('The distance between the sensors is %.1f metres.\n', dist)
fprintf('Cross-correlation took %.1f seconds.\n', time)
fprintf('Calculation in the frequency domain was %.1f times faster that calculation in the time domain.\n', fasterby)

% The offset is 0.4009 seconds.
% The distance between the sensors is 133.5 metres.
% Cross-correlation took 0.7 seconds.
% Calculation in the frequency domain was 741.9 times faster that calculation in the time domain.