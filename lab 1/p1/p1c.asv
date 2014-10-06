% Aysar Khalid
% Problem 1: Detecting Lines
% The following function completes task (7)
function [ ] = p1c( I_c, abc, C_max_edge_points, F)
    %Update D and N to be same as D and N in p1a.m
    D = 3;
    N = 100;
    
    F = F-1; % do not change
    xs = C_max_edge_points(1,:);
    ys = (-abc(1) / abc(2))*C_max_edge_points(1,:) + (-abc(3) / abc(2));
    line_points = [xs;int32(ys)];
    
    % set current line pixels to zero
    % there is some ambiguity to width of line
    for i=1:size(line_points,2)
        c = line_points(1,i);
        r = line_points(2,i);
        if (r>0 && c>0)
            I_c(r,c) = 0;
        end
        if (r-1 > 0)
            I_c(r-1,c) = 0;
            I_c(r-1,c-1) = 0;
            I_c(r-1,c+1) = 0;
        end
        if (c-1 > 0)
            I_c(r,c-1) = 0;
        end
        if (r+1 < size(I_c,1))
            I_c(r+1,c) = 0;
            I_c(r+1,c+1) = 0;
            I_c(r+1,c-1) = 0;
        end
        if (c+1 < size(I_c,2))
            I_c(r,c+1) = 0;
        end
    end
    
    % repeat to find the next line
    p1b(I_c, D, N, F);
end

