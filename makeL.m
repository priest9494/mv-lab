function [Z] = makeL(Z, dim, col, row)
    while 1
        colFound = 0;
        rowFound = 0;
        prevCol = col;
        prevRow = row;
       % Ищем 1 по столбцу
       for i = 1:dim
           if i == prevRow
               continue;
           end
           if Z(i, col) == 1
               row = i;
               Z(row, col) = 0;
               colFound = 1;
               break;
           end
       end
       Z(prevRow, prevCol) = 1;
       
       % Ищем 2 по строке (если нашли по столбцу)
       if colFound == 0
           break;
       end
       
       for i = 1:dim
           if Z(row, i) == 2
               col = i;
               rowFound = 1;
               Z(row, col) = 1;
               break;
           end
       end
       
       if rowFound == 0
           break;
       end
    end