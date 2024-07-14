function result = allRowsEqual(matrix)
    result = all(all(matrix == matrix(1, :), 2));
end