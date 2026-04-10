def character_counts(word):
    character_dict={}

    word = word.lower()
    
    for character in word:
        character_dict[character] = character_dict.get(character, 0) + 1
    return character_dict

def find_anagrams(word, candidates):
    word_character_counts = character_counts(word)

    anagrams=[]
    for candidate in candidates:
        if character_counts(candidate) == word_character_counts and not word.lower() == candidate.lower() :
            anagrams.append(candidate)
    return anagrams
            
