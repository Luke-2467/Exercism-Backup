use std::collections::HashMap;
    
pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    let mut result: u32 = 0;
    let mut found_multiples: HashMap<u32, u32> = HashMap::new();
    for num in factors.iter() {
        if (*num) == 0 {
            continue
        }
        for multiply in 1..=(limit/num) {
            let current_multiple: u32 = (*num) * multiply;
            if num * multiply < limit && !found_multiples.contains_key(&current_multiple){
                result += num * multiply;
                found_multiples.insert( current_multiple,1);
            }
            else if num * multiply >= limit {
                break
            }
        }
    }
    result
}
