function result = allRowsUnique(matrix)
    [~, uniqueRows, ~] = unique(matrix, 'rows', 'stable');
    result = size(uniqueRows, 1) == size(matrix, 1);
end