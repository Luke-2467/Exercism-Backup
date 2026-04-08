def is_triangle(sides):
    a = sides[0]
    b = sides[1]
    c = sides[2]

    if a + b >= c and b + c >= a and a + c >= b and a*b*c > 0:
        return True
    return False
    
def equilateral(sides):
    if len(set(sides)) == 1:
        return is_triangle(sides) and True
    return False


def isosceles(sides):
    if len(set(sides)) <= 2:
        return is_triangle(sides) and True
    return False


def scalene(sides):
    if len(set(sides)) == 3:
        return is_triangle(sides) and True
    return False
