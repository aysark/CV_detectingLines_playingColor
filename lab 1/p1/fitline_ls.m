function [abc, errs, avgerr] = fitline_ls(xyset, idx, scale)

%FITLINE_LS fits a line to a number of 2D points.
%
%   abc = fitline_ls(xy, idx)
%   abc = fitline_ls(xy, idx, scale)
%   [abc, errs] = fitline_ls(xy, idx)
%   [abc, errs] = fitline_ls(xy, idx, scale)
%   [abc, errs, avgerr] = fitline_ls(xy, idx)
%   [abc, errs, avgerr] = fitline_ls(xy, idx, scale)
%
%   returns the coefficients, a, b, c of the line
%      ax + by + c = 0
%   that best fits a number of 2D points.
%   
%   Input arguments:
%   - xyset must be a 3-by-n matrix where each column of the matrix stores
%     one 2D point represented in homgeneous coordinates, and n (being
%     the number of columns of xyset) must be greater than or equal to 2.
%   - idx is a list of integers in the range [1,n].
%   - scale is an optional argument and, if specified, should be just 0,
%     to denote no scaling, and 1, to denote scaling.  By default, some
%     scaling would be applied to the data points prior to computing
%     the least-squares solution.  As a comparison, try the function
%     with and without scaling to see the slight difference in the fitting
%     (a smaller or larger average fitting error, for instance).
%
%   Output arguments: 
%   - abc is the vector storing the three coefficients, a, b, and c, of
%     the line.  Here, abc(1) = a;  abc(2) = b;  abc(3) = c.
%   - errs (optional) stores the array of errors of the line fitting to
%     all the points in xyset:
%        err = mean( sum_{i=1}^n |a*x_i + b*y_i + c| ) / sqrt(a^2+b^2)
%
%   fitline_ls employs the linear least squares method to get an approximation
%   of the coefficients.  More advanced methods will be implemented in the
%   future.
%
%   An appropriate use of input arguments would allow this function to be
%   used with lmeds or ransac.
%
%   SEE ALSO fitplane, lmeds, ransac
%
%Created August 1996
%Revised December 1999
%Revised September 2003
%
%Copyright Du Huynh
%The University of Western Australia
%School of Computer Science and Software Engineering


% check dimensions of input argument
if isempty(idx)
   % the user doesn't care about the list idx, so will use all
   % data points
   idx = 1:size(xyset,2);
   xy = xyset;
elseif any(idx <= 0 | idx > size(xyset,2))
   error('fitline: idx must be an array of integers in the range [1,n], where n=size(xyset,2).');
else
   xy = xyset(:,idx);
end

if size(xy,1) ~= 3 | length(idx) < 2
   error('fitline: xy must be a 3-by-n matrix, with n >= 2.');
end

if nargin == 2, scale = 1; end
if scale
   xy_old = xy;
   xy = pflat(xy);
   range = max(xy(1:2,:),[],2) - min(xy(1:2,:),[],2);
   T = [sqrt(2)/range(1) 0 0; 0 sqrt(2)/range(2) 0; 0 0 1];
   xy = T*xy;
end

A = xy*xy';
abc = lsq(A);
if scale
   % undo the scaling
   abc = T'*abc;
   abc = abc / norm(abc,2);
   % restore xy
   xy = xy_old;
end

if nargout > 1
   errs = abs(abc'*xyset) / sqrt(abc(1)^2 + abc(2)^2);
end
if nargout > 2
   avgerr = mean(errs);
end

return
