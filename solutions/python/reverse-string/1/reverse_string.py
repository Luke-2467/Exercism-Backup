def reverse(text):
    reversed_text=""
    for char_num in range(1,len(text)+1):
        reversed_text+=text[-char_num]
    return reversed_text
        
