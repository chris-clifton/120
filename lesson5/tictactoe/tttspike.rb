class Board
  def initialize
  # need a 3 x 3 grid for the board.  Squares?
  # data structure?
    # array/hash of square objects?
    # array/hash of strings or integers?  
  end
end

class Square
  def initialize
    # a status to keep track of each square's mark
  end
end

class Player
  def initialize
    # a marker to keep track of this player's symbol (x or O)
  end

  def mark
  end
end

class Human < Player
end

class Computer < Player
end

class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?
      
      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
