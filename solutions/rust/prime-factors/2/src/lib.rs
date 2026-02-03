pub fn primes_up_to_n(n: u64) -> Vec<u64> {
    let mut primes: Vec<u64> = vec![2];
    'candidate: for candidate in 3..=n {
        for prime in primes.iter() {
            if candidate.is_multiple_of(*prime) {
                continue 'candidate;
            }
        }
    primes.push(candidate);
    // print!("Newest prime is: {}\n", current_num);
    }

    primes
}


pub fn factors(n: u64) -> Vec<u64> {
    let primes = primes_up_to_n(10000);
    let mut target = n;
    let mut result: Vec<u64> = Vec::new();
    if primes.last() == Some(&target) {
        result.push(target);
        return result;
    }

    for prime in primes.iter() {
        if target < *prime {
            break
        }
        if !target.is_multiple_of(*prime) {
            continue;
        }
        while target.is_multiple_of(*prime) {
            target /= prime;
            result.push(*prime);
        }
    }

    if target != 1 {
        result.push(target)
    }
    result
}
