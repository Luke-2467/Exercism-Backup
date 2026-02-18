use std::collections::HashMap;

pub fn brackets_are_balanced(string: &str) -> bool {
    
let mut current_open_brackets: Vec<char> = Vec::new();

    // Map closing -> opening
    let pairs: HashMap<char, char> = HashMap::from([
        (')', '('),
        (']', '['),
        ('}', '{'),
    ]);

    for character in string.chars() {
        match character {
            '(' | '[' | '{' => current_open_brackets.push(character),
            ')' | ']' | '}' => {
                let Some(top) = current_open_brackets.pop() else { return false; };
                if pairs.get(&character) != Some(&top) {
                    return false;
                }
            }
            _ => {}
        }
    }
    current_open_brackets.is_empty()
}
