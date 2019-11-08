function [determinant,variables] = GaussElimination(sqrmat,results)

%% Inital error check
       if size(sqrmat,1) ~= size(sqrmat,2)
           error("The __ is not square");
       elseif size(sqrmat,1) ~= size(results,1)
           error("The dimensions of results and matrix does not fit");
       end
%% Setup working variables  
       globalsize = size(sqrmat,1);     % A size that will be used often
       workingmat = [sqrmat,results];   % Matrix to work with - combination of the matrix and solution vector
       variables = zeros(globalsize,1); % Preset size of the variables
%% Partial Pivoting       
       for ii = 1:globalsize-1
           [abspivot,pivotindex] = max(abs(workingmat(ii:end,ii)));     % Find pivot index and pivot value
           [abspivotrow, ~] = find(abs(workingmat(:,ii))==abspivot);    % Find pivot row to switch rows
           abspivotrow = abspivotrow(abspivotrow>=ii);                  % to prevent pivot getting set at point behind working col&row
           abspivotrow = abspivotrow(1);                                % to prevent cases where there are multiple pivots
           pivot = workingmat(abspivotrow,ii);                          % Get signed pivot value
           if pivot == 0                                                % Detect error - when the pivot value = 0
               error("This system cannot be solved-leading coefficint = 0");    % Error message
           else
               workingmat([abspivotrow(1,1) ii],:) = workingmat([ii abspivotrow(1,1)],:);   % Switch rows to put pivotrow on top
               if triu(workingmat) == workingmat                          % Early break - when there is nolonger any need to pivot
                   break
               else
%% Forward Elimination                   
                   for sequence = ii:globalsize-1   %/forward elimination
                       workingmat(sequence+1,:) = ...
                       workingmat(sequence+1,:) - ...
                       (workingmat(ii,:)*(workingmat(sequence+1,ii)/pivot)); 
                   end
              end
           end
       end
%% Backword Substitution       
               workingres = workingmat(:,end);          %  Re-split workingmatrix into processed solution vector and matrix
               workingmat = workingmat(:,1:end-1);      
               variables(globalsize) = workingres(globalsize)/ workingmat(globalsize,globalsize); % Last element of final solution
               for iii = globalsize-1:-1:1
                   workingres(1:iii) = workingres(1:iii) - variables(iii+1)*workingmat(1:iii,iii+1);
                   variables(iii) = workingres(iii)/workingmat(iii,iii);
               end
%% Find Determinant              
               determinant = prod(diag(workingmat));

%% Interpretation
% because the forward elimination has much more loops, it takes much more
% time than backword substitution