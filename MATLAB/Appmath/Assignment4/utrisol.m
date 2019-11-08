  function x = utrisol(U,b)
% x = utrisol(U,b)
%
% Solves the nonsingular upper triangular system  Ux = b.
% where U is n-by-n, b is n-by-1, and X is n-by-1.

n = length(b);
x = zeros(n,1);
for j=n:-1:2
   x(j) = b(j)/U(j,j);
   b(1:j-1) = b(1:j-1) - x(j)*U(1:j-1,j);
end
x(1) = b(1)/U(1,1);