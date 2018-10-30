# Initializes suits and values constants and constructor creates a randomized shuffled deck
# deck is an array with a suit @ index 0 and a value @ index 1
class Deck
  attr_reader :cards

  SUITS = %w(hearts clubs diamonds spades)
  VALUES = %w(2 3 4 5 6 7 8 9 10 jack queen king ace)

  def initialize
    @cards = SUITS.product(VALUES).shuffle
  end
end

game_deck = Deck.new
p game_deck.cards