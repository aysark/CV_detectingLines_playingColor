%------------------------------------------------------------------------
% Function to calculate distances between a line and an array of points.
% The line is defined by a 3x2 matrix, L.  The two columns of L defining
% two points that are the endpoints of the line.
%
% A line can be defined with two points as:
%        lambda*p1 + (1-lambda)*p2
% Then, the distance between the line and another point (p3) is:
%        norm( lambda*p1 + (1-lambda)*p2 - p3 )
% where
%                  (p2-p1).(p2-p3)
%        lambda =  ---------------
%                  (p1-p2).(p1-p2)
%
% lambda can be found by taking the derivative of:
%      (lambda*p1 + (1-lambda)*p2 - p3)*(lambda*p1 + (1-lambda)*p2 - p3)
% with respect to lambda and setting it equal to zero

function [inliers, L] = lineptdist(L, X, t)

    p1 = L(:,1);
    p2 = L(:,2);
    
    npts = size(X,1)*size(X,2);
    d = zeros(npts, 1);
    
    for i = 1:npts
        [p3_i,p3_j] = ind2sub(size(X), i);
        p3 = [p3_j;p3_i;1];
      
        lambda = dot((p2 - p1), (p2-p3)) / dot( (p1-p2), (p1-p2) );
        d(i) = ceil(norm(lambda*p1 + (1-lambda)*p2 - p3));
        
    end    
    inliers = find(abs(d) == t);
    