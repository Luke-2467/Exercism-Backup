def find(search_list, value):
    start=0
    end=len(search_list)
    
    while end-start > 0:
        if search_list[(start + end)//2] == value:
            return (start + end)//2
        if search_list[(start + end)//2] < value:
            start = (start + end)//2 + 1
        else:
            end = (start + end)//2
    
    raise ValueError("value not in array")