use std::collections::HashSet;


fn get_sorted(word: String) -> Vec<char> {
    let mut word_sorted: Vec<char> = word.chars().collect();
    word_sorted.sort_unstable();
    word_sorted
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let mut anagrams = HashSet::new();
    let lower_word = word.to_lowercase();
    let sorted_word=get_sorted(lower_word.clone());
   
    for possible_anagram in possible_anagrams {
        let candidate = *possible_anagram; // &&str -> &str

        let lower_candidate = candidate.to_lowercase();
        
        if lower_candidate == lower_word {
            continue;
        }
        
        let sorted_candidate = get_sorted(lower_candidate);
        if sorted_candidate == sorted_word {
            anagrams.insert(candidate); 
        }
    }

    anagrams
}
