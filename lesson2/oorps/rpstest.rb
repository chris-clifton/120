# rps_bonus_features.rb

class Player
  attr_accessor :move, :name, :score

  def initialize
    @score = 0
  end
end

class Human < Player
  def initialize
    set_name
    super
  end

  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choice_match?(value, user_input)
    value.name.casecmp(user_input) == 0
  end

  def create_choice_object(user_input)
    choice = nil
    Move.descendants.each { |value| choice = value if choice_match?(value, user_input) }
    choice.new
  end

  def choose
    user_input = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or Spock:"
      user_input = gets.chomp
      break if Move.descendants.map(&:name).include? user_input.capitalize
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(create_choice_object(user_input))
  end
end

module Descendants
  def descendants
    ObjectSpace.each_object(Class).select { |object_class| object_class < self }
  end
end

class Computer < Player
  extend Descendants

  def history_ai(game_history)
    move_history = game_history.map { |history_item| history_item[:human_move].value.class }
    move_history_hash = move_history.each_with_object(Hash.new(0)) do |choice, count|
      count[choice] += 1
    end
    move_history_hash = move_history_hash.sort_by { |_, value| value }
    most_common_move = move_history_hash.reverse[0][0]
    Move.descendants.select { |move| move.beats(most_common_move) }.sample
  end

  def choose(game_history)
    if game_history.empty?
      self.move = Move.new(Move.descendants.sample.new)
    else
      choice = history_ai(game_history)
      self.move = Move.new(choice.new)
    end
  end
end

class R2D2 < Computer
  attr_accessor :name

  def initialize
    @name = 'R2D2'
  end
end

class RockBot < Computer
  attr_accessor :name

  def initialize
    @name = 'Rock Bot'
  end

  def choose(_)
    self.move = Move.new(Rock.new)
  end
end

class Hal < Computer
  attr_accessor :name

  def initialize
    @name = 'Hal'
  end

  def unused_moves(move_history)
    Move.descendants.reject { |move| move_history.include?(move) }
  end

  def best_move(move_history)
    move_history_hash = move_history.each_with_object(Hash.new(0)) { |move, count| count[move] += 1 }
    average_selection_amount = move_history_hash.values.inject(&:+) / move_history_hash.length
    move_history_hash.reject! { |_, value| value >= average_selection_amount + 2 }
    move_history_hash.map { |key, _| key }
  end

  def history_ai(game_history)
    move_history = game_history.map { |history_item| history_item[:human_move].value.class }
    choice = if !unused_moves(move_history).empty?
               unused_moves(move_history).sample
             else
               best_move(move_history).sample
             end
    Move.descendants.select { |move| move.beats(choice) }.sample
  end

  def choose(game_history)
    if game_history.empty?
      self.move = Move.new(Move.descendants.sample.new)
    else
      choice = history_ai(game_history)
      self.move = Move.new(choice.new)
    end
  end
end

class Chappie < Computer
  attr_accessor :name

  def initialize
    @name = 'Chappie'
  end

  def history_ai(game_history)
    move_history = game_history.map { |history_item| history_item[:human_move].value.class }
    move_history_hash = move_history.each_with_object(Hash.new(0)) { |choice, count| count[choice] += 1 }.sort_by { |_, value| value }
    move_history_hash.reverse[0][0]
  end

  def choose(game_history)
    if game_history.empty?
      self.move = Move.new(Spock.new)
    else
      choice = history_ai(game_history)
      self.move = Move.new(choice.new)
    end
  end
end

class Eva < Computer
  attr_accessor :name

  def initialize
    @name = 'Eva'
  end
end

class WallE < Computer
  attr_accessor :name

  def initialize
    @name = 'Wall-E'
  end

  def choose(_)
    choices = [Lizard, Lizard, Lizard, Lizard, Paper, Paper, Rock, Scissors]
    self.move = Move.new(choices.sample.new)
  end
end

class Move
  extend Descendants

  attr_accessor :value

  def initialize(choice)
    @value = choice
  end

  def >(other_move)
    @value.class.beats(other_move.value.class)
  end

  def to_s
    @value
  end
end

class Rock < Move
  attr_accessor :name

  def initialize
    @name = 'Rock'
  end

  def self.beats(other_class)
    other_class == Scissors || other_class == Lizard
  end
end

class Paper < Move
  attr_accessor :name

  def initialize
    @name = 'Paper'
  end

  def self.beats(other_class)
    other_class == Spock || other_class == Rock
  end
end

class Scissors < Move
  attr_accessor :name

  def initialize
    @name = 'Scissors'
  end

  def self.beats(other_class)
    other_class == Lizard || other_class == Paper
  end
end

class Lizard < Move
  attr_accessor :name

  def initialize
    @name = 'Lizard'
  end

  def self.beats(other_class)
    other_class == Spock || other_class == Paper
  end
end

class Spock < Move
  attr_accessor :name

  def initialize
    @name = 'Spock'
  end

  def self.beats(other_class)
    other_class == Scissors || other_class == Rock
  end
end

class RPSGame
  attr_accessor :human, :computer, :game_history
  MAX_SCORE = 10

  def initialize
    @human = Human.new
    @computer = Computer.descendants.sample.new
    @game_history = []
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock! Goodbye!"
  end

  def display_score
    puts "#{human.name}: #{human.score} | #{computer.name}: #{computer.score}"
  end

  def display_history_list
    game_history.reverse.slice(0, 10).each do |round|
      puts "| #{round[:human_move].value.name}".ljust(20) +
           "| #{round[:computer_move].value.name}".ljust(20) +
           "| #{round[:winner]}".ljust(20) + "|"
    end
  end

  def display_holding_message
    puts "History will appear here"
  end

  def display_hr
    puts "".ljust(61, '-')
  end

  def display_scores
    puts "| #{human.name} (#{human.score})".ljust(20) + "| #{computer.name} (#{computer.score})".ljust(20) +
         "| Result (last 10)".ljust(20) + "|"
  end

  def show_info
    sleep 1
    system('clear') || system('cls')
    display_scores
    display_hr
    game_history.empty? ? display_holding_message : display_history_list
    display_hr
  end

  def overall_winner
    if human.score >= MAX_SCORE
      human
    elsif computer.score >= MAX_SCORE
      computer
    end
  end

  def display_overall_winner
    puts "#{overall_winner.name} won the whole game!!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)?"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def round
    new_round = RPSRound.new(human, computer, game_history)
    new_round.play
    game_history.push(new_round.history)
  end

  def play
    display_welcome_message
    loop do
      reset_scores
      loop do
        show_info
        round
        break if overall_winner
      end
      show_info
      display_overall_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

class RPSRound
  attr_accessor :human, :computer, :history, :game_history

  def initialize(human, computer, game_history)
    @human = human
    @computer = computer
    @history = { human_move: nil, computer_move: nil, winner: nil }
    @game_history = game_history
  end

  def display_moves
    puts "#{human.name} chose #{human.move.value.name}"
    puts "#{computer.name} chose #{computer.move.value.name}"
  end

  def winner
    if human.move > computer.move
      human
    elsif computer.move > human.move
      computer
    end
  end

  def display_winner
    if winner
      puts "#{winner.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def award_point
    winner.score += 1
  end

  def log_history
    history[:human_move] = human.move
    history[:computer_move] = computer.move
    history[:winner] = if winner
                         winner.name
                       else
                         'Draw'
                       end
  end

  def play
    human.choose
    computer.choose(game_history)
    display_moves
    log_history
    award_point if winner
    display_winner
  end
end

RPSGame.new.play