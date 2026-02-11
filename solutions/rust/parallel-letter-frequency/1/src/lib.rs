use std::collections::HashMap;
use std::thread;

/// Merge `map2` into `map1`, summing values for matching keys.
/// Consumes both and returns the merged map.
fn merge_with_sum(mut map1: HashMap<char, usize>, map2: HashMap<char, usize>) -> HashMap<char, usize> {
    for (key, val) in map2 {
        *map1.entry(key).or_insert(0) += val; // use `key` directly (not &key)
    }
    map1
}

/// Count character frequency in a single string.
pub fn frequency_from_string(input: String) -> HashMap<char, usize> {
    let mut char_frequency: HashMap<char, usize> = HashMap::new();
    for ch in input.chars() {
        *char_frequency.entry(ch).or_insert(0) += 1;
    }
    char_frequency
}

/// Count character frequency across many strings using up to `worker_count` threads.
/// Distributes the input roughly evenly and merges the results.
pub fn frequency(input: &[&str], worker_count: usize) -> HashMap<char, usize> {
    if input.is_empty() {
        return HashMap::new();
    }

    // Avoid division by zero; also cap workers at input length
    let workers = worker_count.max(1).min(input.len());
    let len = input.len();
    let base = len / workers;
    let mut remainder = len % workers;

    // We'll spawn scoped threads so we can borrow `&str` safely.
    thread::scope(|scope| {
        let mut start = 0usize;
        let mut handles = Vec::with_capacity(workers);

        for _ in 0..workers {
            // Distribute the remainder one-by-one to the first `remainder` threads
            let extra = if remainder > 0 { remainder -= 1; 1 } else { 0 };
            let end = (start + base + extra).min(len);
            let slice = &input[start..end];
            start = end;

            // Spawn a thread for this chunk. `slice` is a `&[&str]` that is valid
            // as long as we stay inside this `scope`.
            handles.push(scope.spawn(move || {
                let mut partial = HashMap::<char, usize>::new();
                for s in slice {
                    let lower_string = s.to_lowercase();
                    let only_letters = lower_string.chars().filter(|c| c.is_alphabetic()).collect();
                    let m = frequency_from_string(only_letters);
                    partial = merge_with_sum(partial, m);
                }
                partial
            }));
        }

        // Merge results from all threads
        let mut total = HashMap::<char, usize>::new();
        for h in handles {
            let part = h.join().expect("thread panicked");
            total = merge_with_sum(total, part);
        }
        total
    })
}
