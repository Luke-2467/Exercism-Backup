def is_armstrong_number(number):
    digit_sum = 0
    number_of_digits = len(str(number))
    
    for digit in str(number):
        digit_sum += int(digit)**number_of_digits

    return digit_sum == number
        
