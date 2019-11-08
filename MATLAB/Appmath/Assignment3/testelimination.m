A = rand(4,4);
B = rand(4,1);
sqrmat = A; results = B;

       if size(sqrmat,1) ~= size(sqrmat,2)
           error("The __ is not square");
       elseif size(sqrmat,1) ~= size(results,1)
           error("The dimensions of results and matrix does not fit");
       end
       globalsize = size(sqrmat,1);
       workingmat = [sqrmat,results];
       variables = zeros(globalsize,1);
      
       for ii = 1:globalsize-1
           [abspivot,pivotindex] = max(abs(workingmat(ii:end,ii)));
           [abspivotrow, ~] = find(abs(workingmat(:,ii))==abspivot);
           pivot = workingmat(abspivotrow,ii);
           
           %/ pivotrow = pivotindex;
           %/ pivotcol = ii;
           %/ pivotrow=pivotrow(pivotrow>=ii);
           %/ when ii = 2, pivot col & pivot row returns multiple outputs?
           %why check
           %/ when ii = 3, because it detects the whole row, pivotrow reads
           % [1 4], therefore switchmaking goes wrong
           %/ pivotrow needs to be something that outputs 3 4
           %/ how about pivotrow(pivotrow>ii)?
           if pivot == 0 
               error("This system cannot be solved-leading coefficint = 0");
           else
               workingmat([abspivotrow(1,1) ii],:) = workingmat([ii abspivotrow(1,1)],:);
               % this will go wrong when ii=3. b/c if pivoted, no longer
               % need to be processed. more processing will lead to errors.
               if nnz(workingmat(globalsize,1:(globalsize-1))) ==0
                   break
               else
                   for sequence = ii:globalsize-1   %/forward elimination
                       workingmat(sequence+1,:) = ...
                       workingmat(sequence+1,:) - ...
                       (workingmat(ii,:)*(workingmat(sequence+1,ii)/pivot));
                    %/ gone wrong here. when sequence = 2 & ii=1,
                    % workingmat(3,1) = -1
                    %/ doesnot work with new A - when pivotal value is
                    % negative - b/c pivot includes abs - which alwas
                    % returns a positive function. 
                    %/  so i changed pivot to workingmat(pivotrow,pivotrow)
                    %/ this yet casued another problems of ruining when ii
                    %  & sequence =0 why
                    %/ because i refered to pivotrow too early. it hasn't
                    % been rotated yet
                   end
              end
           end
       end
      
               workingres = workingmat(:,end);
               workingmat = workingmat(:,1:end-1);      %/matrix resplit
               variables(globalsize) = workingres(globalsize)/ workingmat(globalsize,globalsize); %/ last element of final solution
              
               for iii = globalsize-1:-1:1
                   workingres(1:iii) = workingres(1:iii) - variables(iii+1)*workingmat(1:iii,iii+1);
                   variables(iii) = workingres(iii)/workingmat(iii,iii);
               end
               
               determinant = prod(diag(workingmat));
               determinant
               variables
               A \ B
               variables == A\B


