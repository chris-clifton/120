require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(number, marker)
    @squares[number].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # Return winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "+-----+-----+-----+"
    puts "|     |     |     |"
    puts "|  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  |"
    puts "|     |     |     |"
    puts "+-----+-----+-----+"
    puts "|     |     |     |"
    puts "|  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  |"
    puts "|     |     |     |"
    puts "+-----+-----+-----+"
    puts "|     |     |     |"
    puts "|  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  |"
    puts "|     |     |     |"
    puts "+-----+-----+-----+"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "
  PLAYER_MARKERS = ['X', 'O']

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :name
  attr_accessor :score, :human, :computer

  RANDOM_AI_NAMES = ['Al', 'C3PO', 'Optimus Prime', 'Bender', 'Mecha-Streisand']

  def initialize(marker, name=RANDOM_AI_NAMES.sample)
    @marker = marker
    @name = name
    @score = 0
  end
end

class TTTGame
  MATCH_WINNING_SCORE = 5

  attr_reader :board
  attr_accessor :current_marker, :human, :computer

  def initialize
    @board = Board.new
    @current_marker = nil
  end

  # private

  def who_goes_first
    puts "Who gets the first move, computer or human?"
    puts "Enter 'c' for computer, or 'h' for human."
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if answer == 'c' || answer == 'h'
      puts "Sorry, please choose either 'c' for computer or 'h' for human."
    end
    case answer
    when 'c'
      @current_marker = computer.marker
    when 'h'
      @current_marker = human.marker
    end
    @current_marker
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe, #{human.name}! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "#{human.name} marker: #{human.marker} || #{computer.name} marker: #{computer.marker}"
    puts "#{human.name} wins: #{human.score}  || #{computer.name} wins: #{computer.score}"
    puts ""
    board.draw
    puts ""
  end

  def choose_computer_marker
    human.marker == 'X' ? 'O' : 'X'
  end

  def initialize_computer
    @computer = Player.new(choose_computer_marker)
  end

  def initialize_human
    name = choose_human_name
    marker = choose_human_marker
    @human = Player.new(marker, name)
  end

  def initialize_both_players
    initialize_human
    initialize_computer
  end

  def choose_human_name
    puts "What is your name?"
    name = nil
    loop do
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, that is not a valid name."
    end
    name
  end

  def choose_human_marker
    puts "Please select either 'X' or 'O' for your marker."
    marker = ''
    loop do
      marker = gets.chomp.upcase!
      break if Square::PLAYER_MARKERS.include?(marker)
      puts "Sorry, that is not a valid choice."
    end
    marker
  end
      
  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry #{human.name}, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def joinor(array, delimiter=', ', word='or')
    case array.size
    when 0 then ''
    when 1 then array.first
    when 2 then array.join(word.to_s)
    else
      array[-1] = "#{word} #{array.last}"
      array.join(delimiter)
    end
  end

  def computer_moves # rename intelligent_computer_move
    # attacks_to_win
    # defends_threat
    #takes_middle_square
    takes_random_square
    #board[square] = computer.marker
  end

  def takes_random_square
    board[board.unmarked_keys.sample] = computer.marker
  end

  def takes_middle_square
    if board.unmarked_keys.include?(5)
      board[5] = computer.marker
    end
  end

  def current_player_moves
    if @current_marker == human.marker
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def display_round_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} wins!"
    when computer.marker
      puts "#{computer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def wins_to_go(player)
    MATCH_WINNING_SCORE - player.score
  end

  def play_again?
    answer = nil
    puts "#{human.name} needs #{wins_to_go(human)} more wins to reach the Match Score."
    puts "#{computer.name} needs #{wins_to_go(computer)} more wins to reach the Match Score."
    loop do
      puts "Would you like to keep playing? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y n].include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    @current_marker = nil
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def update_round_score
    if board.winning_marker == human.marker
      human.score +=1
    elsif board.winning_marker == computer.marker
      computer.score +=1
    end
  end

  def overall_match_winner?
    if human.score >= MATCH_WINNING_SCORE
      human
    elsif computer.score >= MATCH_WINNING_SCORE
      computer
    else
      nil
    end
  end

  def play
    clear
    display_welcome_message
    initialize_both_players
    who_goes_first
    # display_rules

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end

      update_round_score
      display_round_result
      break if overall_match_winner?
      break unless play_again?
      reset
      display_play_again_message
    end
    #display_final_score
      # I want this method to read "overall winner" "x matches to y matches"
    display_goodbye_message
  end

end

game = TTTGame.new
game.play
