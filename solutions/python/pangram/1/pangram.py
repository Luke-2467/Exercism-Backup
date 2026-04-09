import re
def is_pangram(sentence):
    regex = re.compile('[^a-zA-Z]')
    #First parameter is the replacement, second parameter is your input string
    set_sentence_lower_filtered=set(regex.sub('', sentence).lower())

    return len(set_sentence_lower_filtered)==26
