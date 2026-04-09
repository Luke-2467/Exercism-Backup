def response(hey_bob):

    hey_bob=hey_bob.strip()
    
    if hey_bob=="":
        return "Fine. Be that way!"
        
    if hey_bob.isupper() and hey_bob[-1]=="?":
        return "Calm down, I know what I'm doing!"
    
    if hey_bob.isupper():
        return "Whoa, chill out!"

    if hey_bob[-1]=="?":
        return "Sure."

    return "Whatever."
