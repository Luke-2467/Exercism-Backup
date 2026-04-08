"""Solution to Ellen's Alien Game exercise."""


class Alien:
    """Create an Alien object with location x_coordinate and y_coordinate.

    Attributes
    ----------
    (class)total_aliens_created: int
    x_coordinate: int - Position on the x-axis.
    y_coordinate: int - Position on the y-axis.
    health: int - Number of health points.

    Methods
    -------
    hit(): Decrement Alien health by one point.
    is_alive(): Return a boolean for if Alien is alive (if health is > 0).
    teleport(new_x_coordinate, new_y_coordinate): Move Alien object to new coordinates.
    collision_detection(other): Implementation TBD.
    """
    total_aliens_created = 0
    health = 3
    
    def __init__(self, starting_location_x, starting_location_y):
        Alien.total_aliens_created += 1
        self.x_coordinate = starting_location_x
        self.y_coordinate = starting_location_y
        
    def hit(self):
        # Increment the 'number' class variable by 1.
        self.health -= 1

    def is_alive(self):
        if self.health <= 0:
            return False
        return True

    def teleport(self,new_x_coordinate,new_y_coordinate):
        self.x_coordinate = new_x_coordinate
        self.y_coordinate = new_y_coordinate

    def collision_detection(self,other_object):
        pass

    

#TODO:  create the new_aliens_collection() function below to call your Alien class with a list of coordinates.

def new_aliens_collection(list_of_alien_positions):
    alien_objects = []
    for alien in list_of_alien_positions:
        alien_objects.append(Alien(alien[0],alien[1]))      
    return alien_objects
    
