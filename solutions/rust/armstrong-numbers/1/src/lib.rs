pub fn is_armstrong_number(num: u32) -> bool {
    
    const BASE: u32 = 10;
    
    let mut temp_num = num;
    
    let mut result = 0;
    
    let mut power = 0;
    
    while temp_num != 0 {
        temp_num /= BASE;
        power += 1;
    }
    
    let mut temp_num = num;
    
    while temp_num != 0 {
        let current_digit: u32 = temp_num % BASE;
        result += current_digit.pow(power);
        temp_num /= BASE;
    }

    num == result
}
