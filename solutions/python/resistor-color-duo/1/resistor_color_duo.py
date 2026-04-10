def value(colors):
    colour_to_resistence={"black": 0,
    "brown": 1,
    "red": 2,
    "orange": 3,
    "yellow": 4,
    "green": 5,
    "blue": 6,
    "violet": 7,
    "grey": 8,
    "white": 9
    }

    resistence=""
    for color in colors[0:2]:
        resistence+=str(colour_to_resistence[color])
    return int(resistence)
