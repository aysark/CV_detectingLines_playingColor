% Aysar Khalid
% Problem 1: Detecting Lines
% The following function completes task (7)
function [ ] = p1c( I_c, abc, C_max_edge_points_ids, F)
    F = F-1;
    
%     a=[248,80];
%     b=[267,148];
% 
%     x=[a(1) b(1)];
%     y=[a(2) b(2)];
% 
%     X=a(1):b(1);
%     Y=interp1(x,y,X);
%     Y=round(Y)
    
    I_c(intersect(find(I_c), C_max_edge_points_ids)) = 0;
    D = 3;
    N = 1;
    p1b(I_c, D, N, F);
end

