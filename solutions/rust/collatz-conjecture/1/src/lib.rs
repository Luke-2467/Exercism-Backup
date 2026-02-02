pub fn collatz(mut n: u64) -> Option<u64> {
    if n == 0 {
        return None
    }
    let mut steps = 0;
    loop {
        if n == 1 {
            break
        }
        if n.is_multiple_of(2) {
            n /= 2
        }
        else {
            n = 3 * n + 1
        }
        steps += 1;
    }
    Some(steps)
}