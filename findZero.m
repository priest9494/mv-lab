function [col, row] = findZero(M, selectedCols, selectedRows, dim)
    col = -1;
    row = -1;
    nullFound = 0;
    
    for i = 1:dim
        if nullFound == 1
            break;
        end
        
        % Исключаем выделенные строки
        if selectedCols(i) == 1
            continue;
        end
        for j = 1:dim
            
            % Исключаем выделенные столбцы
            if selectedRows(j) == 1
                continue;
            end
            
            if M(j, i) == 0
                row = j;
                col = i;
                nullFound = 1;
                break;
            end
        end
    end