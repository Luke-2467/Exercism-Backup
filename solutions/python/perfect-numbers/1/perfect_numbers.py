def factors_of_a_number(number):
    factors = []

    for candidate in range(1, number//2 + 1):
        if number % candidate == 0:
            factors.append(candidate)
    return set(factors)

def classify(number):
    """ A perfect number equals the sum of its positive divisors.

    :param number: int a positive integer
    :return: str the classification of the input integer
    """

    if number <= 0:
        raise ValueError("Classification is only possible for positive integers.")
    factor_sum=sum(factors_of_a_number(number))

    if factor_sum == number:
        return "perfect"
    if factor_sum < number:
        return "deficient"
    return "abundant"
