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

    if len(colors) > 4:
        value_bands = 3
    else:
        value_bands = 2
        
    for color in colors[0:min(value_bands,len(colors))]:
        resistence+=str(colour_to_resistence[color])
    return int(resistence)


def label(colors):
    '''
    Get the total resistence of a trio of resistors.

    :param colors: list Ordered list of the colours of the resistors
    :return: Resistence in Ohms, Kiloohms, Megaohms or Gigaohms.
    :rtype: str | None
    '''
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
    
    value_bands=value(colors)

    if len(colors) < 3:
        return str(value_bands) + " ohms"

    multiplier_band = 2
    
    if len(colors) > 4:
        multiplier_band = 3
        
    total_resistence = value_bands*10**colour_to_resistence[colors[multiplier_band]]

    if total_resistence == 0:
        return "0 ohms"
    
    for factor, unit in unit_conversions.items():
        if total_resistence >= (10**factor):
            if total_resistence % (10**factor) == 0:
                return str(total_resistence//(10**factor)) + " " + unit
            return str(total_resistence/(10**factor)) + " " + unit 
    return None

def resistor_label(colors):
    resistor_tolerance = {
        "grey": "±0.05%",
        "violet": "±0.1%",
        "blue": "±0.25%",
        "green": "±0.5%",
        "brown": "±1%",
        "red": "±2%",
        "gold": "±5%",
        "silver": "±10%"
    }

    resistence=label(colors)

    if len(colors) < 4:
        return resistence
    
    return label(colors) + " " + resistor_tolerance[colors[-1]]