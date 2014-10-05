% Aysar Khalid
% Problem 1: Detecting Lines
% The following function completes sets up the args to the main function
function [ ] = p1a(  )
    close all;
    D = 3;
    N = 10;
    F = 5;
%     I = rgb2gray(imread('images/small2.png'));
    I = rgb2gray(imresize(imread('images/b_rect22.jpg'),0.15));
    imshow(I,'InitialMagnification','fit');
    title('Original'); 
    
    I_c = edge(I,'canny');
    p1b(I_c, D, N, F);
end

