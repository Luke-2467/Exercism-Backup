
pub fn egg_count(mut display_value: u32) -> usize {
    let mut count = 0;
    while display_value != 0 {
        display_value &= display_value - 1; // clears the lowest set bit
        count += 1;
    }
    count
}
