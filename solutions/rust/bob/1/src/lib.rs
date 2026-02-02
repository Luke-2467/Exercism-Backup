

fn is_all_uppercase(s: &str) -> bool {
    let has_letters = s.chars().any(|c| c.is_alphabetic());
    has_letters
        && s.chars()
            .filter(|c| c.is_alphabetic())
            .all(|c| c.is_uppercase())
}

pub fn reply(message: &str) -> &str {
    let message_trimmed = message.trim();

    if message_trimmed.is_empty() {
        "Fine. Be that way!"
    }
    else if is_all_uppercase(message_trimmed) && message_trimmed.ends_with('?') {
        "Calm down, I know what I'm doing!"
    }
    else if is_all_uppercase(message_trimmed) {
        "Whoa, chill out!"
    }
    else if  message_trimmed.ends_with('?') {
        "Sure."
    }
    
    else {
        "Whatever."
    }
}
