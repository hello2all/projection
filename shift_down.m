function matrix_out = shift_down(matrix_in)
    n = size(matrix_in, 2);
    add_on = zeros(1, n);
    matrix_out = [add_on; matrix_in];
    matrix_out = matrix_out(1:end-1, :);
end