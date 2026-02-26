"""Functions used in preparing Guido's gorgeous lasagna.
"""


EXPECTED_BAKE_TIME=40
PREPARATION_TIME_IN_MINUTES_PER_LAYER=2

def bake_time_remaining(elapsed_bake_time):
    """Calculate the bake time remaining.

    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - remaining bake time (in minutes) derived from 'EXPECTED_BAKE_TIME'.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """
    return EXPECTED_BAKE_TIME - elapsed_bake_time

def preparation_time_in_minutes(number_of_layers):
    """Calculate the preperation time for n layers.

    :param number_of_layers: int - Number of layers.
    :return: int - preperation time (in minutes) derived from 'PREPARATION_TIME_IN_MINUTES_PER_LAYER'.

    Function that takes the number of layers of the lasagna as
    an argument and returns how many minutes it will take to prepare it
    based on the `PREPARATION_TIME_IN_MINUTES_PER_LAYER` constant.
    """

    return number_of_layers*PREPARATION_TIME_IN_MINUTES_PER_LAYER


def elapsed_time_in_minutes(number_of_layers,elapsed_bake_time):
    """Calculate the elapsed time preparing and cooking a lasagna.

    :param number_of_layers: int - Number of layers.
    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - elapsed time preparing a lasgna (in minutes) derived from 'PREPARATION_TIME_IN_MINUTES_PER_LAYER'.

    Function that takes the number of layers of the lasagna  and amount of time it has been baked for
    as an argument and returns how many minutes it will take to prepare it
    based on the `PREPARATION_TIME_IN_MINUTES_PER_LAYER` constant.
    """

    return PREPARATION_TIME_IN_MINUTES_PER_LAYER*number_of_layers + elapsed_bake_time
