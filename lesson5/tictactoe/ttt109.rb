# Tic Tac Toe with Bonus Features

WINNING_MATCH_SCORE = 5
WHO_GOES_FIRST = 'choose' # options are 'player' 'computer' and 'choose'
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(msg)
  puts "=> #{msg}"
end

def invalid_choice
  prompt 'Sorry, that is not a valid choice.'
end

# rubocop: disable Metrics/AbcSize, Metrics/MethodLength
def display_board(brd, game_score)
  system 'clear'
  puts "Player Marker: X || Computer Marker: O"
  puts "Player Wins: #{game_score[:player_score]}"
  puts "Computer Wins: #{game_score[:computer_score]}"
  puts "Draws: #{game_score[:draws]}"
  puts ""
  puts "     |     |     "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
  puts ""
end
# rubocop: enable Metrics/AbcSize, Metrics/MethodLength

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

def choose_first_player
  if WHO_GOES_FIRST == 'choose'
    loop do
      prompt 'Please choose who will go first: player or computer'
      answer = gets.chomp.downcase
      return 'player' if answer == 'player'
      return 'computer' if answer == 'computer'
      invalid_choice
    end
  else
    WHO_GOES_FIRST
  end
end

def alternate_player(current_player)
  if current_player == 'player'
    'computer'
  elsif current_player == 'computer'
    'player'
  end
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def take_middle_square(brd)
  5 if brd[5] == INITIAL_MARKER
end

def take_random_square(brd)
  empty_squares(brd).sample
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    # rubocop: disable Metrics/LineLength
    board.select { |key, value| line.include?(key) && value == INITIAL_MARKER }.keys.first
    # rubocop: enable Metrics/LineLength
  end
end

def computer_attack_to_win(brd)
  best_move(brd, COMPUTER_MARKER)
end

def computer_defend_threat(brd)
  best_move(brd, PLAYER_MARKER)
end

def best_move(brd, marker)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(marker) == 2 &&
       brd.values_at(*line).count(INITIAL_MARKER) == 1
      then line.select do |square|
        return square if empty_squares(brd).include?(square)
      end
    end
    next
  end
  nil
end

def computer_places_piece!(brd)
  square = computer_attack_to_win(brd)
  square = computer_defend_threat(brd) unless square
  square = take_middle_square(brd) unless square
  square = take_random_square(brd) unless square
  brd[square] = COMPUTER_MARKER
end

def player_places_piece!(brd)
  square = ' '
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))})"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    invalid_choice
  end
  brd[square] = PLAYER_MARKER
end

def place_piece!(brd, current_player)
  if current_player == 'player'
    player_places_piece!(brd)
  elsif current_player == 'computer'
    computer_places_piece!(brd)
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def play_again?
  loop do
    prompt "Play again? (y or n)"
    answer = gets.chomp
    if answer.downcase == 'y'
      return false
    elsif answer.downcase == 'n'
      return true
    else invalid_choice
    end
  end
end

def calculate_score(board, game_score)
  if detect_winner(board) == 'Player'
    game_score[:player_score] += 1
  elsif detect_winner(board) == 'Computer'
    game_score[:computer_score] += 1
  else
    game_score[:draws] += 1
  end
end

def calculate_winner(game_score)
  if game_score[:player_score] >= WINNING_MATCH_SCORE
    'Player'
  elsif game_score[:computer_score] >= WINNING_MATCH_SCORE
    'Computer'
  elsif game_score[:draws] >= WINNING_MATCH_SCORE
    'Nobody'
  else
    false
  end
end

def display_winner(game_score)
  p "#{calculate_winner(game_score)} wins the match!"
end

loop do # Main Program loop
  game_score = { player_score: 0, computer_score: 0, draws: 0 }
  board = initialize_board
  display_board(board, game_score)
  prompt "Welcome to Tic Tac Toe!"
  prompt "Win five rounds to win the match!"
  current_player = choose_first_player

  loop do
    board = initialize_board
    display_board(board, game_score)

    loop do
      display_board(board, game_score)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board, game_score)
    calculate_score(board, game_score)

    if someone_won?(board)
      prompt "---#{detect_winner(board)} won!---"
    else
      prompt "---It's a tie!---"
    end

    break if calculate_winner(game_score)
    break if play_again?
  end

  display_winner(game_score)

  break
end

prompt "Thanks for playing Tic Tac Toe!"
