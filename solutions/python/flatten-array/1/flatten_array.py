def is_iterable(obj):
    try:
        iter(obj)
        return True
    except TypeError:
        return False

def check_any_iterables(list):
    for object in list:
        if is_iterable(object) or object == None:
            return True
    return False

def flatten(iterable):
    if not is_iterable(iterable):
        return iterable
    steps = 0
    while check_any_iterables(iterable) and steps < 100:
        result = []
        for object in iterable:
            if is_iterable(object):
                result.extend(object)
            elif not object == None: 
                result.append(object)
        iterable = result
        steps += 1
    return iterable
