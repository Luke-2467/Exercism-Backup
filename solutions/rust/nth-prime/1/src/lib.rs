pub fn nth(n: u32) -> u32 {
    let mut primes = vec![2, 3, 5, 7, 11, 13, 17, 19];
    if n < primes.len().try_into().unwrap() {
        return primes[n as usize]
    }
    let mut current_num: u32 = 23;
    'candidate: loop {
        for prime in primes.iter() {
            if current_num.is_multiple_of(*prime) {
                current_num += 2;
                continue 'candidate;
            }
        }

    if n + 1 == primes.len().try_into().unwrap() {
        return primes[n as usize]
    }
    primes.push(current_num);
    // print!("Newest prime is: {}\n", current_num);
    current_num += 2;
    }
}
