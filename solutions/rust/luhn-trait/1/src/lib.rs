pub trait Luhn {
    fn valid_luhn(&self) -> bool;
}

impl<T> Luhn for T where T: ToString {
    fn valid_luhn(&self) -> bool {
        let code: String = self
            .to_string()
            .chars()
            .filter(|c| !c.is_whitespace()) // ignore spaces/tabs/newlines
            .collect();
        if code.len() < 2 {
            return false
        }
    
        let mut result=0;
        for (index, num_char) in code.chars().rev().enumerate() {
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
}
