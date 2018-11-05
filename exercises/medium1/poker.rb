class Card
  attr_reader :rank, :suit
  include Comparable

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(@rank, @rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end
  
  # Select one card at random
  def draw
    reset if @deck.empty?
    @deck.pop
  end

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

class PokerHand
  def initialize(cards)
    @cards = []
    @rank_count = Hash.new(0)

    5.times do
      card = cards.draw
      @cards << card
      @rank_count[card.rank] += 1
    end
  end

  def print
    puts @cards
  end

  def evaluate
    case
    when royal_flush?     then 'Royal Flush'
    when straight_flush?  then 'Straight Flush'
    when four_of_a_kind?  then 'Four of a Kind'
    when full_house?      then 'Full House'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a Kind'
    when two_pair?        then 'Two Pair'
    when pair?            then 'Pair'
    else                       'High Card'
    end
  end

  private

  def royal_flush?
    straight_flush? && @cards.min.rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def n_of_a_kind?(number)
    @rank.count.one? { |_, count| count == number }
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end

  def flush?
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit }
  end

  def straight?
    return false if @rank_count.any? { |_, count| count > 1 }
    @cards.min.value == @cards.max.value - 4
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    n_of_a_kind?(2)
  end

  def pair?
  end
end


hand = PokerHand.new(Deck.new)
p hand
