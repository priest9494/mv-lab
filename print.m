function [] = print(M, Z, selectedRows, selectedCols, dim, debug)
    if debug == 0
        return;
    end
    
    fprintf("\n");
    for i = 1:dim
        for j = 1:dim
            if Z(i, j) == 1
               if selectedRows(i) == 1 || selectedCols(j) == 1
                  cprintf('-err', '%d\t', M(i,j));  
               else
                  cprintf('err', '%d\t', M(i,j)); 
               end
               
            elseif Z(i, j) == 2
               if selectedRows(i) == 1 || selectedCols(j) == 1
                  cprintf('-key', '%d\t', M(i,j)); 
               else
                  cprintf('key', '%d\t', M(i,j)); 
               end
            else
               if selectedRows(i) == 1 || selectedCols(j) == 1
                  cprintf('-text', '%d\t', M(i,j));
               else
                  cprintf('text', '%d\t', M(i,j));
               end
            end 
        end
        fprintf("\n");
    end