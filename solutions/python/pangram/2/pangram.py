import re
def is_pangram(sentence):
    regex = re.compile('[^a-zA-Z]')
    
    set_sentence_lower_filtered=set(regex.sub('', sentence).lower())

    return len(set_sentence_lower_filtered)==26
