DEBUG = 0;
MINIMIZE = 1;
M = [
    9, 11, 3, 6, 6;
    10, 9, 11, 5, 6;
    8, 10, 5, 6, 4;
    6, 8, 10, 4, 9;
    11, 10, 9, 8, 7
];

FAILCASE = [
    1, 1, 1, 1, 1;
    1, 9, 11, 5, 6;
    1, 10, 5, 6, 4;
    1, 8, 10, 4, 9;
    1, 10, 9, 8, 7
];

[res] = task(FAILCASE, MINIMIZE, DEBUG);
str = sprintf('Результат минимизации: %d', res);
disp(str);
[res] = task(FAILCASE, ~MINIMIZE, DEBUG);
str = sprintf('Результат максимизации: %d', res);
disp(str);