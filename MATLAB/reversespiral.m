function tmatrix = reversespiral(n)
tmatrix = zeros(n,n)
hv = 1:n;                           % initial vector used to fill up matrix
linedirec = 1;                      % increase/decrease - to reduce rep.
for ii = 1:n
    tmatrix(ii,hv) = hv;            % top line(horizontal)
    max(hv) = counter;              % get maximum # of vector to modify for line 2 vertical
    hv(1:ii) = [];                  % decreas total size to fit the vector to the matrix
    tmatrix(hv,n) = (counter-ii)+hv;% right line(vertical)
                                    % need to be flipping - using
                                    % linedirec, 