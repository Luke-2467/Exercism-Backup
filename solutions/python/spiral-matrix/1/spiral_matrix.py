def spiral_matrix(size):
    result_matrix=[[0]*size for dim in range(size)]
    
    row_change = 0
    column_change = 1

    current_row = 0
    current_column = 0

    min_row = 1
    max_row = size - 1

    min_column = 0
    max_column = size - 1
    
    current_input = 1

    while current_input <= size * size:
        result_matrix[current_row][current_column] = current_input

        current_input += 1

        if current_column == max_column and column_change == 1:
            column_change = 0
            max_column -= 1
            row_change = 1

        elif current_row == max_row and row_change == 1:
            row_change = 0
            max_row -= 1
            column_change = -1

        elif current_column == min_column and column_change == -1:
            column_change = 0
            min_column += 1
            row_change = -1

        elif current_row == min_row and row_change == -1:
            row_change = 0
            min_row += 1
            column_change = 1

        current_row += row_change
        current_column += column_change
        
    return result_matrix