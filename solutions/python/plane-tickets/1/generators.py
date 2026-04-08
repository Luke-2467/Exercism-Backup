"""Functions to automate Conda airlines ticketing system."""


def generate_seat_letters(number):
    """Generate a series of letters for airline seats.

    :param number: int - total number of seat letters to be generated.
    :return: generator - generator that yields seat letters.

    Seat letters are generated from A to D.
    After D it should start again with A.

    Example: A, B, C, D

    """

    seat_letters = ["A", "B", "C", "D"]

    for seat_number in range(number): 
        yield seat_letters[seat_number % 4]


def generate_seats(number):
    """Generate a series of identifiers for airline seats.

    :param number: int - total number of seats to be generated.
    :return: generator - generator that yields seat numbers.

    A seat number consists of the row number and the seat letter.

    There is no row 13.
    Each row has 4 seats.

    Seats should be sorted from low to high.

    Example: 3C, 3D, 4A, 4B

    """

    missing_rows = [13]
    
    seat_letters = generate_seat_letters(number)

    missing_row_add=0
    for seat_number in range(number):
        row = seat_number // 4 + 1 + missing_row_add
        if row in missing_rows:
            missing_row_add += 1
            row += 1
        
        yield str(row) + next(seat_letters)

def assign_seats(passengers):
    """Assign seats to passengers.

    :param passengers: list[str] - a list of strings containing names of passengers.
    :return: dict - with the names of the passengers as keys and seat numbers as values.

    Example output: {"Adele": "1A", "Björk": "1B"}

    """

    number_of_passengers = len(passengers)

    seats = generate_seats(number_of_passengers)
    
    passenger_dict=dict()
    for passenger in passengers:
        passenger_dict[passenger]=next(seats)
    return passenger_dict
    
def generate_codes(seat_numbers, flight_id):
    """Generate codes for a ticket.

    :param seat_numbers: list[str] - list of seat numbers.
    :param flight_id: str - string containing the flight identifier.
    :return: generator - generator that yields 12 character long ticket codes.

    """
    for seat_number in seat_numbers:
        seat_and_flight = seat_number + flight_id
        yield str(seat_and_flight) + "0" * (12-len(seat_and_flight))
    
