def distance(strand_a, strand_b):

    if not len(strand_a) == len(strand_b):
        raise ValueError("Strands must be of equal length.")
        
    hamming_distance = 0
    
    for piece_num in range(len(strand_a)):
        if not strand_a[piece_num] == strand_b[piece_num]:
            hamming_distance += 1
    return hamming_distance
