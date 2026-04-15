import math

def coprime_check(a,m):
    if math.gcd(a,m) is not 1:
        raise ValueError("a and m must be coprime.")

def encode(plain_text, a, b):
    m = 26

    coprime_check(a,m)
    
    GROUP_LENGTH = 5
    plain_text = "".join(char for char in plain_text if char.isalnum())

    encoded_text = ""
    for char_num, char in enumerate(plain_text):
        if (char_num + 1) % GROUP_LENGTH == 1 and char_num > 0:
            encoded_text += " "
        if char.isnumeric():
            encoded_text += char
            continue
            
        encoded_text += chr( ( a*(ord(char.lower())-ord("a")) + b ) % m + ord("a"))

    return encoded_text
    
def decode(ciphered_text, a, b):
    m = 26

    coprime_check(a,m)

    a_inverse = pow(a, -1, m)
    
    ciphered_text = "".join(char for char in ciphered_text if char.isalnum())

    decoded_text = ""
    
    for char_num, char in enumerate(ciphered_text):
        if char.isnumeric():
            decoded_text += char
            continue
        
        decoded_text += chr( ( a_inverse*(ord(char.lower())-ord("a") - b ) ) % m + ord("a"))

    return decoded_text
