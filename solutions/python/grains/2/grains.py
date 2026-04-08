NUMBER_OF_SQUARES = 64

def square(number):
    if number <= 0 or number > NUMBER_OF_SQUARES:
        raise ValueError("square must be between 1 and 64")
    return 2**(number-1)


def total():
    return 2**(NUMBER_OF_SQUARES)-1
