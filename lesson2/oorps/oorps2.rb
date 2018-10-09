require 'pry'
MATCH_TYPES = [1, 3, 5, 10]
winning_match_score = 0

def prompt(msg)
  puts("=> #{msg}")
end

def clear_screen
  system('clear') || system('cls')
end

# This method needs improvement.  First, 3 wins != best of 3, etc. Additionally, it does not work at all.
def choose_match_type(winning_match_score)
  answer = 0
  loop do
    prompt("Please select match type:")
    puts "(1) Sudden Death!"
    puts "(3) Best of three"
    puts "(5) Best of five"
    puts "(10) First to ten"
    answer = gets.chomp.to_i
    break if MATCH_TYPES.include? answer
  end
  winning_match_score = answer
end



class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def to_s
    @value.capitalize
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
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

class Player
  attr_accessor :move, :name, :score

  def initialize
    # set_name
    @score = 0
    @history = []
  end
end

class Human < Player
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
    @history << choice
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 2'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
    @history << self.move
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

  def display_match_length
    case winning_match_score
    when 2
      puts "Best of three!"
    when 3
      puts "Best of five!"
    when 10
      puts "First to ten!"
    end
  end

  def display_goodbye_message
    prompt("Thanks for playing Rock, Paper, Scissors, Lizard, Spock!")
  end

  def display_info
    clear_screen
    display_match_length
    puts "#{human.name} score: #{human.score}"
    puts "#{computer.name} score: #{computer.score}"
    puts ""
  end

  def display_round_winner
    prompt("#{human.name} chose #{human.move}.")
    prompt("#{computer.name} chose #{computer.move}.")
    prompt(" #{calculate_round_winner}")
    end

  def calculate_round_winner
    if human.move.greater_than?(computer.move)
      human.score += 1
      "#{human.name} won!"
    elsif human.move.less_than?(computer.move)
      computer.score += 1
      "#{computer.name} won!"
    else
      "It's a tie- no points!"
    end
  end

  def match_winner?
    (human.score >= winning_match_score) ||
      (computer.score >= winning_match_score)
  end

  def display_match_winner
    prompt("#{@human.name} won #{@human.score} rounds.")
    prompt("#{@computer.name} won #{@computer.score} rounds.")
    puts ""
    if @human.score > @computer.score
      prompt("#{@human.name} won the match!")
    else prompt("#{@computer.name} won the match!")
    end
  end

  def play_again?
    answer = nil
    loop do
      prompt("Play next round? (y/n)")
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      prompt("Sorry, must be y or n.")
    end
    return true if answer == 'y'
    false
  end

  def play
    display_welcome_message
    human.set_name
    computer.set_name
    # choose_match_type(winning_match_score)
    loop do
      display_info
      human.choose
      computer.choose
      display_round_winner
      # binding.pry
      break if match_winner?
      break unless play_again?
    end
    display_match_winner
    display_goodbye_message
  end
end

RPSGame.new.play
