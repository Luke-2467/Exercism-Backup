# Game status categories
# Change the values as you see fit
STATUS_WIN = 'win'
STATUS_LOSE = 'lose'
STATUS_ONGOING = 'ongoing'


class Hangman:
    def __init__(self, word):
        self.remaining_guesses = 9
        self.status = STATUS_ONGOING
        self.word = word
        self.masked_word = "_"*len(word)
        self.guessed_letters = []

    def guess(self, char):
        if not self.status == STATUS_ONGOING:
            raise ValueError("The game has already ended.")
        if char not in self.word or char in self.guessed_letters:
            self.remaining_guesses -= 1
        self.guessed_letters.append(char)
        self.masked_word = ""
        for letter in self.word:
            if letter in self.guessed_letters:
                self.masked_word += letter
            else:
                self.masked_word += "_"
                
        if self.masked_word == self.word:
            self.status = STATUS_WIN
        elif self.remaining_guesses < 0:
            self.status = STATUS_LOSE
        
        
    def get_masked_word(self):
        return self.masked_word

    def get_status(self):
        return self.status
