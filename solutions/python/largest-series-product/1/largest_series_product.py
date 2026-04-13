import math

def largest_product(series, size):
    if len(series) < size:
        raise ValueError("span must not exceed string length")
    if not series.isnumeric():
        raise ValueError("digits input must only contain digits")
    if size < 0:
        raise ValueError("span must not be negative")
        
    current_max = 0
    for index in range(len(series)-size+1):
        current_max = max(current_max, math.prod(list(map(int, series[index:index+size]))))
    return current_max
