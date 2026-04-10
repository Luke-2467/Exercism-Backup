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

def label(colors):
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
    
    unit_conversions={9: "gigaohms",
    6 : "megaohms",
    3 : "kiloohms",
    0 : "ohms"       
    }
    
    two_colors=value(colors)

    total_resistence = two_colors*10**colour_to_resistence[colors[2]]

    if total_resistence == 0:
        return "0 ohms"
    
    for factor, unit in unit_conversions.items():
        if total_resistence % (10**factor) == 0:
            return str(total_resistence//(10**factor)) + " " + unit

    