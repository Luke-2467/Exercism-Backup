pub fn abbreviate(phrase: &str) -> String {
    let words: Vec<&str>= phrase
    .split(&[' ', '-', '\t'])
    .filter(|&r| r != "").collect();

    let mut acronym: String = String::new();

    let mut previous_character: char = 'a';
    
    for word in words{
        previous_character='a';
        
        for (index,character) in word.chars().enumerate() {
            if ( character.is_ascii_uppercase() && !previous_character.is_ascii_uppercase() ) || 
                ( character.is_ascii_lowercase() && index == 0 ) {
                acronym.push(character.to_ascii_uppercase());
            }

            previous_character = character;
        }
    }

    acronym
}
