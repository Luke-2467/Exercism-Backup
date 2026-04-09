def convert(number):
    """
    Converts a number to a string of Pling, Plang, Plong if it is divisible by 3, 5, or 7 respectively. If not divisible by any of these, returns the numeber.
    : param number: Number to be converted, defaults to None
    : type number: integer
    : return : Pling, Plang, Plong or the original number. 
    : rtype : String
    """
    result=""
    if number % 3 == 0:
        result+="Pling"
    if number % 5 == 0:
        result += "Plang"
    if number % 7 == 0:
        result += "Plong"

    if result == "":
        return str(number)

    return result