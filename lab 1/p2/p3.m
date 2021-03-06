% Aysar Khalid
% Problem 2: Playing with Color
% The following function implements task (3)
function [ ] = p3( )
%     original_image = 'images/surf_small.png';
    original_image = 'images/ironman.jpg';
    I = imread(original_image);
    bins = 299;
    non_skin_value = 0.2;
    % sample various types of skins to build a diverse skin histogram
    skin_histogram = p2('images/skin.jpg', zeros(300), bins, 0);
    skin_histogram = p2('images/skin2.jpg', skin_histogram, bins, 0);
    skin_histogram = p2('images/skin3.jpg', skin_histogram, bins, 0);
    skin_histogram = p2('images/skin4.jpg', skin_histogram, bins, 0);
    skin_histogram = p2('images/skin5.jpg', skin_histogram, bins, 0);
    skin_histogram = p2('images/skin6.jpg', skin_histogram, bins, 0);
    skin_histogram = p2('images/skin7.jpg', skin_histogram, bins, 0);
    
    [H S V] = rgb_to_hsv(original_image);
    
    [rows  cols] = size(I(:,:,1));
    mono_image_v = zeros(rows, cols);
    
    for col=1:cols
        for row=1:rows
            hist_r = int32(H(row,col) * bins) + 1;
            hist_c = int32(S(row,col) * bins) + 1;
            if (hist_r > 0) && (hist_c > 0)
                skin_histogram_value = skin_histogram(hist_r,hist_c);
                if (skin_histogram_value >= 1)
                    mono_image_v(row,col) = skin_histogram(hist_r,hist_c);
                else
                    mono_image_v(row,col) = non_skin_value;
                end
            else
                mono_image_v(row,col) = non_skin_value;
            end
        end
    end

    mono_image = H;
    mono_image(:,:,2) = S;
    mono_image(:,:,3) = mono_image_v;
    mono_image_path = 'images/skin_highlighted.jpg';
    mono_image_rgb = hsv2rgb(mono_image);
    imwrite(mono_image_rgb,mono_image_path);
    
    figure;
    imshow(I);
    title('Original Image');
    
    figure;
    h = fspecial('gaussian',[3 3],5);
    mono_image_smooth = imfilter(mono_image_rgb,h);
    imshow(mono_image_smooth);
    title('Skin Highlighted');
end

