require 'pry'

# The classes for each Move were created but they can't "beat" each other.  Must be done before moving on.
# History array is holding Move obejects but the output looks like shit
# Need to create computer AI based on history once fixed

winning_match_score = 3

def prompt(msg)
  puts("=> #{msg}")
end

def clear_screen
  system('clear') || system('cls')
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  # Is this getter/setter doing anything? Remove if not.
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def to_s
    @value.capitalize
  end

  def greater_than?(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?) ||
      (rock? && other_move.lizard?) ||
      (lizard? && other_move.spock?) ||
      (spock? && other_move.scissors?) ||
      (scissors? && other_move.lizard?) ||
      (lizard? && other_move.paper?) ||
      (paper? && other_move.spock?) ||
      (spock? && other_move.rock?)
  end

  def less_than?(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?) ||
      (lizard? && other_move.rock?) ||
      (spock? && other_move.lizard?) ||
      (scissors? && other_move.spock?) ||
      (lizard? && other_move.scissors?) ||
      (paper? && other_move.lizard?) ||
      (spock? && other_move.paper?) ||
      (rock? && other_move.spock?)
  end
end

class Rock < Move
  attr_accessor :name
  
  def initialize
    @name = 'Rock'
  end
end

class Paper < Move
  attr_accessor :name

  def initialize
    @name = 'Paper'
  end
end

class Scissors < Move
  attr_accessor :name

  def initialize
    @name = 'Scissors'
  end
end

class Lizard < Move
  attr_accessor :name

  def initialize
    @name = 'Lizard'
  end
end

class Spock < Move
  attr_accessor :name
  
  def initialize
    @name = 'Spock'
  end
end

class Player
  attr_accessor :move, :name, :score, :history

  def initialize
    @score = 0
    @history = []
  end
end

class Human < Player
  def initialize
    super
  end

  def set_name
    n = ''
    loop do
      prompt("What's your name?")
      n = gets.chomp
      break unless n.empty?
      prompt("Sorry, must enter a value.")
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      prompt("Please choose: Rock, Paper, Scissors, Lizard, or Spock.")
      choice = gets.downcase.chomp
      break if Move::VALUES.include? choice
      prompt("Sorry, invalid choice.")
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 2'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    prompt("Welcome to Rock, Paper, Scissors, Lizard, Spock!")
    prompt("Press any key to continue")
    gets.chomp
  end

  def display_goodbye_message
    prompt("Thanks for playing Rock, Paper, Scissors, Lizard, Spock!")
  end

  def display_scoreboard
    clear_screen
    puts "#{human.name} wins: #{human.score} || #{computer.name} wins: #{computer.score}"
    puts ""
  end

  def display_round_winner
    puts ""
    if round_winner
      prompt("#{round_winner.name} won!")
    else
      prompt("It's a tie- no points awarded!")
    end
    puts ""
  end

  def round_winner 
    if human.move.greater_than?(computer.move)
      human
    elsif computer.move.greater_than?(human.move)
      computer
    end
  end

  def calculate_score
    round_winner.score += 1
  end  

  def add_move_to_history
    human.history << human.move
    computer.history << computer.move
  end

  def display_move_history
    prompt("#{human.name} previous moves: #{human.history}")
    prompt("#{computer.name} previous moves: #{computer.history}")
  end

  def match_winner?(match_score)
    (human.score >= match_score) ||
      (computer.score >= match_score)
  end

  def display_match_winner
    prompt("#{@human.name} won #{@human.score} rounds.")
    prompt("#{@computer.name} won #{@computer.score} rounds.")
    puts ""
    prompt("#{round_winner.name} won the match!")
  end

  def display_moves
    prompt("#{human.name} chose #{human.move}...")
    prompt("#{computer.name} chose #{computer.move}...")
  end

  def play_next_round?
    answer = nil
    loop do
      prompt("Play next round? (y/n)")
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      prompt("Sorry, must be y or n.")
    end
    return true if answer == 'y'
    false
  end

  def play(winning_match_score)
    display_welcome_message
    human.set_name
    computer.set_name
    loop do
      display_scoreboard
      human.choose
      computer.choose
      display_moves
      display_round_winner
      calculate_score if round_winner
      add_move_to_history
      # display_move_history
      break if match_winner?(winning_match_score)
      break unless play_next_round?
    end
    #display_scoreboard
    display_match_winner
    display_goodbye_message
  end
end

RPSGame.new.play(winning_match_score)
