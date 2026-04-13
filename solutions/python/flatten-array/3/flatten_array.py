def is_iterable(obj):
    try:
        iter(obj)
        return True
    except TypeError:
        return False

def flatten(iterable):
    flattened=[]
    for item in iterable:
        if is_iterable(item):
            flattened.extend(flatten(item))
        elif item is not None:
            flattened.append(item)
    return flattened