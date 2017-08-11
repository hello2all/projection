function matrix_out = shift_up(matrix_in)
    n = size(matrix_in, 2);
    add_on = zeros(1, n);
    matrix_out = [matrix_in; add_on];
    matrix_out = matrix_out(2:end, :);
end
