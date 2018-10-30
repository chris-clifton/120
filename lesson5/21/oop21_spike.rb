require 'pry'

class Player
  def initialize
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
  end
end

class Dealer
  def initialize
  end
end

class Participant
  def initialize
  end

  def hit
  end

  def stay
  end

  def busted?
  end
end

class Deck
  def initialize
    # need some data structure to keep track of cards
    # array, hash, something else?
  end

  def deal
  end
end

class Card
  def initialize
    # what are the states of a card?
  end
end

class Game
  def initialize
  end

  def display_welcome_message
    puts "Welcome to 21!"
  end

  def display_goodbye_message
    puts "Thanks for playing 21!"
  end

  def start
    # the sequence of steps to execute game play
    display_welcome_message
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
    play_again?
    display_goodbye_message
  end

  def compare_totals
    # will definitely need to know about cards to produce some total
  end
end


Game.new.start