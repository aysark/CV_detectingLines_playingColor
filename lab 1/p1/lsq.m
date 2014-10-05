function [x,sval,sval_ratio] = lsq(A)

%LSQ returns the least squares solution of the given matrix.
%
%   x = lsq(A)
%   [x,sval] = lsq(A)
%   [x,sval,sval_ratio] - lsq(A)
%   returns the vector, x, that corresponds to the smallest singular value of
%   matrix A.  That is, the function returns the vector, x, that minimises
%           || A*x ||^2
%
%   Input argument:
%   - A the matrix of interest
%
%   Output arguments:
%   - vector x is the least squares solution
%   - sval (optional) is the smallest singular value
%   - sval_ratio is the ratio between the smallest singular value and the
%     next smaller singular value.  The magnitude of the values sval and
%     sval_ratio gives an indication of how accurate x is.
%
%Copyright Du Huynh
%The University of Western Australia
%School of Computer Science and Software Engineering

[U,S,V] = svd(A);
last = size(V,2);
x = V(:,last);
if nargout >= 2
   s = diag(S);
   if length(s) < last
      sval = 0;
   else
      sval = s(last);
   end
end
if nargout >= 3
   sval_ratio = sval / s(last-1);
end

return