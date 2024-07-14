function stra_matrix = GenerateStraMatrix(L, M)

values = 0:1/L:1;
numValues = length(values);
combinations = cell(1, M);
[combinations{:}] = ndgrid(1:numValues);
combinations = cellfun(@(x) reshape(x,[],1), combinations, 'uni', 0);
indices = unique(cat(2, combinations{:}), 'rows');
stra_matrix = values(indices);

% Sort based on row sums
[~, rowSumOrder] = sort(sum(stra_matrix, 2), 'descend');
stra_matrix = stra_matrix(rowSumOrder, :);

% Sort rows with equal sums based on column values
for i = 1:size(stra_matrix, 1)
    for j = i+1:size(stra_matrix, 1)
        if sum(stra_matrix(i, :)) == sum(stra_matrix(j, :))
            if ~isequal(stra_matrix(i, :), stra_matrix(j, :)) && ...
               any(stra_matrix(i, :) > stra_matrix(j, :))
                temp = stra_matrix(i, :);
                stra_matrix(i, :) = stra_matrix(j, :);
                stra_matrix(j, :) = temp;
            end
        end
    end
end

% Ensure output is a column vector for M=1
if M == 1
    stra_matrix = flipud(stra_matrix(:));
end

end
