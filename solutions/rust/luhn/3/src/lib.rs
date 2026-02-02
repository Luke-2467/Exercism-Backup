pub fn is_valid(code: &str) -> bool {
    let no_white_space=code.replace(" ","");
    
    if no_white_space.len() < 2 {
        return false
    }
    
    let mut result=0;
    for (index, num_char) in no_white_space.chars().rev().enumerate() {
    if !num_char.is_numeric() {
            return false
        }
    let num: i32 = num_char as i32 - 0x30;
        
        if index % 2 == 1 && num != 9 {
                result += ( num * 2 ) % 9;
        }
        else {
            result += num;
        }
    }

    result % 10 == 0
}
