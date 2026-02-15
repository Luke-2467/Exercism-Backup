pub fn build_proverb(list: &[&str]) -> String {
    let mut output = String::new();

    if list.len() == 0 {
        return output
    }

    for index in 1..list.len() {
        let current = list[index];
        let previous = list[index - 1];
        let string_to_add = format!("For want of a {previous} the {current} was lost.\n");
        output.push_str(&string_to_add);
    }

    let first_item = list[0];

    let last_sentence = format!("And all for the want of a {first_item}.");
    output.push_str(&last_sentence);

    output
}
