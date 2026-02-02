pub fn verse(bottles: u32) -> String {
    let current = num_word(bottles, true);
    let next = num_word(bottles.saturating_sub(1), false);

    format!(
        "{current} green bottle{plural} hanging on the wall,\n\
{current} green bottle{plural} hanging on the wall,\n\
And if one green bottle should accidentally fall,\n\
There'll be {next} green bottle{next_plural} hanging on the wall.\n",
        plural = if bottles == 1 { "" } else { "s" },
        next_plural = if bottles.saturating_sub(1) == 1 { "" } else { "s" },
    )
}

pub fn recite(start_bottles: u32, take_down: u32) -> String {
    let mut song = String::new();

    for bottle_num in (start_bottles.saturating_sub(take_down - 1)..=start_bottles).rev() {
        song.push_str(&verse(bottle_num));

        // blank line between verses, but not after the last one (optional)
        if bottle_num != start_bottles.saturating_sub(take_down - 1) {
            song.push('\n');
        }
    }

    song
}

fn num_word(n: u32, capitalized: bool) -> &'static str {
    match (n, capitalized) {
        (0, _) => if capitalized { "No" } else { "no" },
        (1, _) => if capitalized { "One" } else { "one" },
        (2, _) => if capitalized { "Two" } else { "two" },
        (3, _) => if capitalized { "Three" } else { "three" },
        (4, _) => if capitalized { "Four" } else { "four" },
        (5, _) => if capitalized { "Five" } else { "five" },
        (6, _) => if capitalized { "Six" } else { "six" },
        (7, _) => if capitalized { "Seven" } else { "seven" },
        (8, _) => if capitalized { "Eight" } else { "eight" },
        (9, _) => if capitalized { "Nine" } else { "nine" },
        (10, _) => if capitalized { "Ten" } else { "ten" },
        _ => "many", // or panic!/format! if you only expect 0..=10
    }
}