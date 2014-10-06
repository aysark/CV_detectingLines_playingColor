% Aysar Khalid
% Problem 2: Playing with Color
% The following function implements task (1)
function [H,S,V ] = rgb_to_hsv(image_path)
    %image_path = 'images/2x2.png';
    rgb_image = im2double(imread(image_path));
    r = rgb_image(:,:,1);
    g = rgb_image(:,:,2);
    b = rgb_image(:,:,3);
    
    H = repmat(r,1);
    S = H;
    V = H;
    
    for i=1:numel(r)
        v = max([r(i) g(i) b(i)]);
        m = min([r(i) g(i) b(i)]);
        c = v - m;
        
        if (v ~= 0)
            s = c / v;
            
            if (c == 0)
                h_ = 0;
            elseif (v == r(i))
                h_ = mod(((g(i) - b(i)) / c), 6);
            elseif (v == g(i))
                h_ = ((b(i) - r(i)) / c) + 2;
            elseif (v == b(i))
                h_ = ((r(i) - g(i)) / c) + 4;
            end
            h = 60*h_;
        else
            s = 0;
            h = -1;
        end
        
        H(i) = h/360; % divide by 360 to get [0,1] bound
        S(i) = s;
        V(i) = v;
    end
    H
    S
    V
end

