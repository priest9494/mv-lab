function [selectedRows, selectedCols] = mark(Z, size)
    selectedRows = zeros(1, size);
    selectedCols = zeros(1, size);
    
    for i = 1:size
        starFound = 0;
        hatchFound = 0;
        for j = 1:size
            if Z(i, j) == 1
                starFound = 1;
                starIdx = j;
            end
            if Z(i, j) == 2
                hatchFound = 1;
            end
        end
        
        if starFound == 1
            if hatchFound == 1
                selectedRows(i) = 1;
            else
                selectedCols(starIdx) = 1;
            end
        end
    end