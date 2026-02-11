use std::collections::HashMap;

const PACK_PRICE_CENTS: [u32; 6] = [0, 800, 1520, 2160, 2560, 3000];

pub fn lowest_price(books: &[u32]) -> u32 {
    let counts = counts_from_ids(books);
    price_cents_from_counts(counts)
}

/// Convert a list of book IDs (1..=5) into counts per title (0-based).
/// Invalid IDs are ignored for robustness (you can tighten this if desired).
fn counts_from_ids(ids: &[u32]) -> [u8; 5] {
    let mut counts = [0u8; 5];
    for &id in ids {
        if (1..=5).contains(&id) {
            let idx = (id - 1) as usize;
            counts[idx] = counts[idx].saturating_add(1);
        }
    }
    counts
}

pub fn price_cents_from_counts(counts: [u8; 5]) -> u32 {
    let mut memo: HashMap<[u8; 5], u32> = HashMap::new();
    best_price(counts, &mut memo)
}

/// Internal recursive solver with memoization.
fn best_price(counts: [u8; 5], memo: &mut HashMap<[u8; 5], u32>) -> u32 {
    if counts == [0; 5] {
        return 0;
    }
    if let Some(&cached) = memo.get(&counts) {
        return cached;
    }

    let mut best = u32::MAX;

    // Try all non-empty subsets of {0,1,2,3,4}, mask 1..31.
    for mask in 1..(1 << 5) {
        // Form this group if possible (i.e., each selected title has at least one copy).
        let mut new_counts = counts;
        let mut size = 0;
        let mut valid = true;

        for i in 0..5 {
            if (mask & (1 << i)) != 0 {
                if new_counts[i] == 0 {
                    valid = false;
                    break;
                }
                new_counts[i] -= 1;
                size += 1;
            }
        }

        if !valid {
            continue;
        }

        let candidate = PACK_PRICE_CENTS[size] + best_price(new_counts, memo);
        if candidate < best {
            best = candidate;
        }
    }

    memo.insert(counts, best);
    best
}


