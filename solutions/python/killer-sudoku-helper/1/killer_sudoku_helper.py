from itertools import combinations as all_combinations

def combinations(target, size, exclude):
    possible_candidates=set(range(1,10))
    candidates=set(range(1,10)).difference(set(exclude))

    valid_combinations=[]
    for combination in all_combinations(candidates,size):
        if sum(combination) == target:
            valid_combinations.append(list(combination))
    return valid_combinations