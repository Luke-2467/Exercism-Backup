import re
def is_valid(isbn):
    regex = re.compile('[^0-9A-Za-z]')
    
    isbn_filtered=regex.sub('', isbn)

    if len(isbn_filtered) != 10:
        return False

    check_sum=0
    
    for char_num in range(10):
        current_digit=isbn_filtered[char_num]
        
        if current_digit == "X" and char_num == 9:
            current_digit=10
        
        if not str(current_digit).isnumeric():
            return False
        
        check_sum+=(10-char_num)*int(current_digit)

    return check_sum % 11 == 0 