def score(x_coordinate, y_coordinate, radius_1=1, radius_2=5, radius_3=10, points_1=10, points_2=5, points_3=1):
    distance_from_centre = x_coordinate**2+y_coordinate**2

    if distance_from_centre > radius_3**2:
        return 0
    elif distance_from_centre > radius_2**2:
        return points_3
    elif distance_from_centre > radius_1**2:
        return points_2
    return points_1
    
