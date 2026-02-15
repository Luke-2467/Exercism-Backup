/// Return the Hamming distance between the strings,
/// or None if the lengths are mismatched.
pub fn hamming_distance(s1: &str, s2: &str) -> Option<usize> {
    if s1.len() != s2.len() {
        return None
    }
    
    let mut hamming_distance: usize = 0;

    let s2_char_vec: Vec<char> = s2.chars().collect();
    
    for (index, character) in s1.char_indices() {
        if character != s2_char_vec[index] {
            hamming_distance += 1;
        }
    }
    Some(hamming_distance)
}
