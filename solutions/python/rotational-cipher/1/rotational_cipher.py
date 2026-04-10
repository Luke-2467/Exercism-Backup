def rotate(text, key):
    capital_starting_order=ord("A")
    lower_starting_order=ord("a")
    rotated_text=""
    for character in text:
        if not character.isalpha():
            rotated_text+=character
            continue
        if character.isupper():
            starting_ord=capital_starting_order
        else:
            starting_ord=lower_starting_order
        rotated_text+=chr((ord(character)-starting_ord+key) % 26 + starting_ord)
    return rotated_text