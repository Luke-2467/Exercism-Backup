pub fn series(digits: &str, len: usize) -> Vec<String> {
    
    let mut output_vec: Vec<String> = Vec::new();

    if digits.len() < len {
        return output_vec
    }
    
    for sub_string_start in 0..(digits.len()-len+1) {
        output_vec.push(digits[sub_string_start..sub_string_start+len].to_string())
    }

    output_vec
}
