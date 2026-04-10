def commands(binary_str):
    instruction_dict={
        1 : "wink",
        2 : "double blink",
        4 : "close your eyes",
        8 : "jump"
    }

    handshake=[]
    for bit, action in instruction_dict.items():
        if int(binary_str,2) & bit > 0:
            handshake.append(action)
    if int(binary_str,2) & 16 > 0:
        return handshake[::-1]
    return handshake