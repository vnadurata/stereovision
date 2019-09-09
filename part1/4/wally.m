% Uses 2D cross correlation to find the Rocket Man in the Maze.

tic
% Reads the data in and converts RGB to pixel intensities.
rocketman = sum(imread('wallypuzzle_rocket_man.png'), 3)/3;  % Template
[rockety, rocketx] = size(rocketman);  % Dimensions of the template
puzzlecolour = imread('wallypuzzle_png.png');
puzzlegray = sum(puzzlecolour, 3)/3;  % Search region

% Calculates the 2D normalised cross correlation, finds the position of the
% maximum value, and converts this to the coordinate closest to the centre
% of Rocket Man.
R = normcorr2D(rocketman, puzzlegray);
[~, maxind] = max(R, [], 'all', 'linear');
[maxy, maxx] = ind2sub(size(R), maxind);
waly = floor(maxy-(rockety/2-1));
walx = floor(maxx-(rocketx/2-1));

% Places a red star centered on Rocket Man.
redstar = imread('red_star_processed.png');
for x = 1:60
    for y = 1:60
        if redstar(y, x, 2) == 0
            puzzlecolour(y+waly-30, x+walx-30, :) = redstar(y, x, :);
        end
    end
end
imwrite(puzzlecolour, 'wallypuzzle_found.png')

time = toc;

% Prints the result
fprintf('Rocket Man is at x = %d, y = %d\n', walx, waly)
fprintf('Cross-correlation took %.1f seconds.\n', time)

% The output is:
% Rocket Man is at x = 1038, y = 590
% Cross-correlation took 637.9 seconds.
