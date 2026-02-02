pub fn annotate(garden: &[&str]) -> Vec<String> {
    // Empty input => empty output
    if garden.is_empty() {
        return vec![];
    }

    let rows = garden.len();
    let cols = garden[0].chars().count();

    // Convert each row to Vec<char> for indexing
    // (Also assumes garden is rectangular; if not, we return a best-effort result.)
    let grid: Vec<Vec<char>> = garden.iter().map(|row| row.chars().collect()).collect();

    let mut result = Vec::with_capacity(rows);

    for row in 0..rows {
        let mut out_row = String::with_capacity(cols);

        for col in 0..cols {
            // If this cell is a flower, copy it
            if grid[row][col] == '*' {
                out_row.push('*');
                continue;
            }

            // Otherwise count adjacent flowers (8 neighbors)
            let mut count: u8 = 0;

            for adjacent_row_change in -1i8..=1 {
                for adjacent_col_change in -1i8..=1 {
                    // Skip current cell
                    if adjacent_row_change == 0 && adjacent_col_change == 0 {
                        continue;
                    }

                    let adjacent_row = row as i8 + adjacent_row_change;
                    let adjacent_col = col as i8 + adjacent_col_change;

                    if adjacent_row >= 0 && adjacent_row < rows as i8 && adjacent_col >= 0 && adjacent_col < cols as i8 {
                        if grid[adjacent_row as usize][adjacent_col as usize] == '*' {
                            count += 1;
                        }
                    }
                }
            }

            // If no adjacent flowers, keep empty; else put digit
            if count == 0 {
                out_row.push(' ');
            } else {
                out_row.push(char::from_digit(count as u32, 10).unwrap());
            }
        }

        result.push(out_row);
    }

    result
}