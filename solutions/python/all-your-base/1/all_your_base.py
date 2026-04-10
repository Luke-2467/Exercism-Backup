import math

def to_base_10(input_base,digits):
    power=len(digits)-1

    base_10_integer=0

    for digit in digits:
        if digit < 0:
            raise ValueError("all digits must satisfy 0 <= d < input base")
        if digit >= input_base:
            raise ValueError("all digits must satisfy 0 <= d < input base")
        
        base_10_integer+=digit*input_base**power
        power-=1

    return base_10_integer

def from_base_10(target_base,base_10_integer):

    if base_10_integer == 0:
        return [0]
        
    power=math.floor(math.log(base_10_integer, target_base))

    target_base_digits=[0]*(power+1)

    for target_base_digit_num in range(len(target_base_digits)):
        target_base_digits[target_base_digit_num]=base_10_integer//(target_base**power)

        base_10_integer -= target_base_digits[target_base_digit_num]*target_base**power
        power -= 1
    return target_base_digits

def rebase(input_base, digits, output_base):
    if input_base < 2:
        raise ValueError("input base must be >= 2")
        
    if output_base < 2:
        raise ValueError("output base must be >= 2")
        
    if digits == []:
        return [0]
        
    base_10_integer=to_base_10(input_base,digits)
    
    return from_base_10(output_base,base_10_integer) 
    
