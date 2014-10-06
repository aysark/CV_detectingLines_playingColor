% Aysar Khalid
% Problem 2: Playing with Color
% The following function implements task (2)
% bins represents how many ranges in the histogram
% plotting = 1 or 0, whether you want to plot graphs or not
function [ new_histogram ] = p2(image_path, histogram, bins, plotting)
    % p2('images/2x2.png',zeros(30), 29, 1)
    % p2('images/skin.jpg',zeros(30), 29, 1)
%     close all; 
    %image_path = 'images/2x2.png';

    rgbImage = imread(image_path);
    [H, S, V] = rgb_to_hsv(image_path);

    [rows cols] = size(rgbImage);
    subplot(2,2,1);
    imshow(rgbImage);
    title('Color Image');
    
    if (plotting == 1)
        % hue histogram plot
        [hCounts hValues] = hist(H(:), bins);
        subplot(2,2,3);
        bar(hValues, hCounts);
        title('Histogram of Hue');

        % saturation histogram plot
        [sCounts sValues] = hist(S(:), bins);
        subplot(2,2,4);
        bar(sValues, sCounts);
        title('Histogram of Saturation');
    end
    
    % 2d histogram
    [rows cols] = size(H);
    new_histogram = histogram;
    
    for col=1:cols
        for row=1:rows
            % Iterate through the image H and S colormaps
            % getting each element and normalizing it
            r = int32(H(row,col) * bins) + 1;
            c = int32(S(row,col) * bins) + 1;
            % get histogram position and increment it by a vote
            new_histogram(r, c) = histogram(r, c) + 1; 
        end
    end
    
    if (plotting == 1)
        subplot(2,2,2);
        imshow(new_histogram, []);
        title('2D Histogram of Hue vs. Saturation'); 
        xlabel('Saturation');
        ylabel('Hue');
    end
end

