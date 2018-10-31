require 'pry'

class Participant
  attr_accessor :hand, :cards_total
  attr_reader :name

  def initialize
    @hand = []
    @cards_total = 0
  end

  def hit!(deck)
    puts "#{self.name} chooses to hit."
    self.hand << deck.pop
  end

  def stay
    puts "#{self.name} will stay."
  end

  def busted?
    cards_total > 21 ? true : false
  end

  def cards_total
    values = hand.map { |card| card[1] }
    
    sum = 0
    values.each do |value|
      if value == 'ace'
        sum += 11
      elsif value.to_i == 0
        sum += 10
      else
        sum += value.to_i
      end
    end
    
    # adjusts ace to 1 if sum > 21 and accounts for multiple aces
    values.select { |card| card == 'ace'}.count.times do
      sum -= 10 if sum > 21
    end
    sum
  end
end

class Player < Participant
  attr_accessor :name
  def initialize
    super
    @name = pick_a_name
  end

  def pick_a_name
    puts "Hello Player, what is your name?"
    answer = nil
    loop do
      answer = gets.chomp
      break unless answer.strip.empty?
      puts "Please choose a valid name."
    end
    self.name = answer
  end

  def hit_or_stay?
    puts "Would you like to hit or stay?"
      answer = nil
      loop do
        answer = gets.chomp
        break if answer == 'hit' || answer == 'stay'
        puts "Sorry, that is not a valid option."
      end
    answer
  end
end

class Dealer < Participant
  def initialize
    super
    @name = "Dealer"
  end
end

class Deck
  attr_accessor :cards

  SUITS = %w(hearts clubs diamonds spades)
  VALUES = %w(2 3 4 5 6 7 8 9 10 jack queen king ace)

  def initialize
    @cards = SUITS.product(VALUES).shuffle
  end
  
end

class Card
  def initialize
    # what are the states of a card?
  end
end

class Game
  attr_reader :game_deck
  attr_accessor :player, :dealer, :winner

  def initialize
    display_welcome_message
    @game_deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
    @winner = nil
    # p game_deck
  end

  def display_welcome_message
    puts "Welcome to 21!"
  end

  def display_goodbye_message
    puts "Thanks for playing 21!"
  end

  def deal_cards!
    puts "Dealing cards..."
    2.times do 
      player.hand << game_deck.cards.pop
      dealer.hand << game_deck.cards.pop
    end
  end

  def display_cards
    puts "#{player.name}: #{player.hand}"
    puts "Card total: #{player.cards_total} "
    puts
    puts "Dealer: #{dealer.hand[0]} and HIDDEN."
    puts "Card total: ???"
    puts
  end

  def player_turn
    loop do
      player_choice = player.hit_or_stay?

      if player_choice == 'hit'
        player.hit!(game_deck.cards)
        puts "You drew a #{player.hand.last}."
        puts "Your total is now #{player.cards_total}."
      end

      break if player_choice == 'stay' || player.busted? 
    end
  end

  def dealer_turn
    puts "#{dealer.name}'s turn..."
    loop do
      break if dealer.cards_total >= 17 || player.busted?
      dealer.hit!(game_deck.cards)
      puts "#{dealer.name} draws the #{dealer.hand.last}."
    end

    if dealer.busted?
      puts "Dealer busts."
    else
      puts "Dealer stays."
    end
  end

  def winner?
    # need to only compare card totals here...busts should automatically end the game
    # depend on busted? method short-circuiting
    if player.busted? || dealer.cards_total > player.cards_total
      @winner = dealer.name
    elsif dealer.busted? || player.cards_total > dealer.cards_total
      @winner = player.name
    # else
    #   @winner = 'nil'
    end
  end

  def show_result
    puts "#{player.name} has #{player.hand} for a total of #{player.cards_total}."
    puts "#{dealer.name} has #{dealer.hand} for a total of #{dealer.cards_total}."
    puts "And the winner is #{winner}!"
  end

  # def calculate_winner(player, dealer)
  #   if player > dealer && (player.busted? == false)
  #     player.name
  #   elsif dealer > player && (dealer.busted? == false)
  #     dealer.name
  #   else
  #     "It's a tie.  Nobody "
  #   end
  # end

  def play_again?
    puts "----------------"
    puts "Would you like to play again?"
    answer = gets.chomp.downcase
    answer.downcase.start_with?('y')
  end

  def reset
    @game_deck = Deck.new
    @winner = nil
    player.hand = []
    dealer.hand = []
  end

  def start
    # the sequence of steps to execute game play
    loop do
      # instructions?
      deal_cards!
      display_cards
      player_turn
      dealer_turn
      winner?
      show_result
      play_again? ? reset : break
      end
    display_goodbye_message
  end
end


Game.new.start
