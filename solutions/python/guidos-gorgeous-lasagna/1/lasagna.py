"""Functions used in preparing Guido's gorgeous lasagna.

Learn about Guido, the creator of the Python language:
https://en.wikipedia.org/wiki/Guido_van_Rossum

This is a module docstring, used to describe the functionality
of a module and its functions and/or classes.
"""


#TODO: define your EXPECTED_BAKE_TIME (required) and PREPARATION_TIME (optional) constants below.
EXPECTED_BAKE_TIME=40
PREPARATION_TIME_IN_MINUTES_PER_LAYER=2

#TODO: Remove 'pass' and complete the 'bake_time_remaining()' function below.
def bake_time_remaining(elapsed_bake_time):
    """Calculate the bake time remaining.

    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - remaining bake time (in minutes) derived from 'EXPECTED_BAKE_TIME'.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """
    return EXPECTED_BAKE_TIME - elapsed_bake_time


#TODO: Define the 'preparation_time_in_minutes()' function below.
# To avoid the use of magic numbers (see: https://en.wikipedia.org/wiki/Magic_number_(programming)), you should define a PREPARATION_TIME constant.
# You can do that on the line below the 'EXPECTED_BAKE_TIME' constant.
# This will make it easier to do calculations, and make changes to your code.

def preparation_time_in_minutes(number_of_layers):
    """Calculate the preperation time for n layers.

    :param number_of_layers: int - Number of layers.
    :return: int - preperation time (in minutes) derived from 'PREPARATION_TIME_IN_MINUTES_PER_LAYER'.

    Function that takes the number of layers of the lasagna as
    an argument and returns how many minutes it will take to prepare it
    based on the `PREPARATION_TIME_IN_MINUTES_PER_LAYER` constant.
    """

    return number_of_layers*PREPARATION_TIME_IN_MINUTES_PER_LAYER


#TODO: define the 'elapsed_time_in_minutes()' function below.
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
