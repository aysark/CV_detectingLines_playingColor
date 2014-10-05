% Aysar Khalid
% Problem 2: Playing with Color
% The following function implements task (3)
function [ ] = p3( )
    close all;
    original_image = 'images/2x2.png';
    I = imread(original_image);
    
    skin_histogram = p2('images/skin.jpg', zeros(30));
    
    [H S V] = rgb_to_hsv(original_image);
    % to get a monochrome image, we only use V
    %original2_image = 'images/surf_small.jpg';
    
    [counts, bins] = imhist(rgb2gray(I));
    
    [rows  cols] = size(I(:,:,1));
    mono_image_v = zeros(rows, cols);
    
    for col=1:cols
        for row=1:rows
            % if the skin color
            % is same as skin color of original image
            histogram_value = skin_histogram(int32(H(row,col)/30), int32(S(row,col)/30));
            if (H(row,col) == H(row,col)/30) && ()

            HS_original_image = [H(row,col) S(row,col)];            
            %color of corresponding image (I(r,c))
            %color = impixel(I,[row],[col]);
            %get pixel's intensity/vote count based on bins of histogram
            %set that count to mono image's
            mono_image_v(row,col) = ;
            
        end
    end
    %set mono_image's H and S colormaps to zero
    mono_image = [zeros(rows,cols) zeros(rows,cols) mono_image_v];
    imwrite(mono_image, 'images/2x2_gray.png');
    imshow('images/2x2_gray.png');
end

