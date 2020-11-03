function [res] = task(M, minimize, debug)
    copyM = M;
    size = length(M);
    res = 0;
    % Матрица для маркировки нулей
    Z = zeros(size, size);
    % Массивы для выделения строк и столбцов
    selectedCols = zeros(1, size);
    selectedRows = zeros(1, size);
    
    % Приведение к задаче максимизации
    if minimize ~= 1
        maxInM = max(max(M));
        for i = 1:size
            for j = 1:size
                M(i, j) = maxInM - M(i, j);
            end
        end
    end

    % Вычитаем минимум по столбцу
    M = M - min(M);
    %Вычитаем минимум по строке
    M = M';
    M = M - min(M);
    M = M';
    
    % Предварительный этап - строим СНН
    nnCount = 0;
    for i = 1:size
       for j = 1:size
           if M(j, i) == 0
               if max(Z(j, :)) == 0
                  Z(j, i) = 1;
                  nnCount = nnCount + 1;
                  break;
               end
           end
       end
    end
    
    print(M, Z, selectedRows, selectedCols, size, debug);
    
    iterNumber = 0;
    remarkNeeds = 1;
    while 1
        iterNumber = iterNumber + 1;
        
        if debug 
            str = sprintf('\n%d)',iterNumber);
            disp(str);
        end
        
        if remarkNeeds
            if nnCount == size
                print(M, Z, selectedRows, selectedCols, size, debug);
                print(copyM, Z, selectedRows, selectedCols, size, 1);
                
                for i = 1:size
                    for j = 1:size
                        if Z(i, j) == 1
                            res = res + copyM(i, j);
                        end
                    end
                end
                
                break;
            end
            
            [selectedRows, selectedCols] = mark(Z, size);
            remarkNeeds = 0;
        end
        
        
        print(M, Z, selectedRows, selectedCols, size, debug);
        [col, row] = findZero(M, selectedCols, selectedRows, size);
        
        % Среди невыделенных элементов присутствуют нули?
        if col ~= -1
            % Отмечаем 0'
            Z(row, col) = 2;
            
            % В одной строке с 0' есть 0*?
            starMarkedExists = 0;
            for i = 1:size
                if Z(row, i) == 1
                    markedRow = row;
                    markedCol = i;
                    starMarkedExists = 1;
                    break;
                end
            end
            
            % Да
            if starMarkedExists == 1
                selectedCols(markedCol) = 0;
                selectedRows(markedRow) = 1;
                if debug
                    fprintf("Перекидываем выделение со столбца на строку:\n");
                end
            % Нет
            else
                [Z] = makeL(Z, size, col, row);
                nnCount = nnCount + 1;
                remarkNeeds = 1;
                if debug
                    fprintf("Строим L-цепочку:\n");
                end
            end
        % Нет    
        else
            % Находим минимальный элемент матрицы
            matrixMin = max(max(M));
            for i = 1:size
                if selectedRows(i) == 1
                    continue;
                end
                for j = 1:size
                    if selectedCols(j) == 1
                        continue;
                    end
                    if M(i, j) ~= 0 && M(i, j) < matrixMin
                        matrixMin = M(i, j);
                    end
                end
            end
            % Выполняем эквивалентное преобразование
            if debug
                fprintf("Выполняем эквивалентное преобразование:\n");
            end
            for i = 1:size
                for j = 1:size
                    % Вычитаем минимум из невыделенных столбцов
                    if selectedCols(j) == 0
                       M(i, j) = M(i, j) - matrixMin;
                    end
                    % Добавляем минимум к выделенным строкам
                    if selectedRows(i) == 1
                       M(i, j) = M(i, j) + matrixMin;
                    end
                end
            end
        end
    end