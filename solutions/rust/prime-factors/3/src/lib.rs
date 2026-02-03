pub fn factors(n: u64) -> Vec<u64> {
    let mut target = n;
    
    let mut result: Vec<u64> = Vec::new();

    for candidate in 2..=n {
        if target == 1 {
            break
        }
        
        while target.is_multiple_of(candidate) {
            target /= candidate;
            result.push(candidate);
        }
    }
    
    result
}
