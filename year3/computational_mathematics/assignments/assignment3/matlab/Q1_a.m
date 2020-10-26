matA = [-2 1 0; 1 -2 1; 0 1 -1.5];
matB = [4 -1 0 1 0; -1 4 -1 0 1; 0 -1 4 -1 0; 1 0 -1 4 -1; 0 1 0 -1 4];

fprintf("\nInfinityNorm(matA) = %d",InfinityNorm(matA));
fprintf("\nInfinityNorm(matB) = %d",InfinityNorm(matB));


function N = InfinityNorm(A)
    [m,n] = size(A);
    rows = [];
    for i=1 : n
        row = 0;
        for j=1 : m
            row = row + abs(A(i,j));
        end
        rows = [rows, row];
    end
    N = max(rows(:));
end

