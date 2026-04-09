import re
def is_isogram(string):
    regex = re.compile('[^a-zA-Z]')
    
    sentence_lower_filtered=regex.sub('', string).lower()
    set_sentence_lower_filtered=set(sentence_lower_filtered)
    
    return len(set_sentence_lower_filtered)==len(sentence_lower_filtered)
