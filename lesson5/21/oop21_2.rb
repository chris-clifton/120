class Participant
  attr_accessor :hand, :cards_total
  attr_reader :name

  def initialize
    @hand = []
    @cards_total = 0
  end

  def hit!(deck)
    puts "#{name} chooses to hit."
    hand << deck.pop
  end

  def stay
    puts "#{name} will stay."
  end

  def busted?
    cards_total > 21
  end

  def cards_total
    values = hand.map { |card| card[1] }
    sum = 0
    values.each do |value|
      sum += 11 if value == 'Ace'
      sum += 10 if value.to_i == 0
      sum += value.to_i
    end

    # adjusts ace to 1 if sum > 21 and accounts for multiple aces with count
    values.select { |card| card == 'Ace' }.count.times do
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
    puts 'Hello Player, what is your name?'
    answer = nil
    loop do
      answer = gets.chomp
      break unless answer.strip.empty?
      puts 'Please choose a valid name.'
    end
    self.name = answer
  end

  def hit_or_stay?
    puts 'Would you like to hit or stay?'
    answer = nil
    loop do
      answer = gets.chomp
      break if answer == 'hit' || answer == 'stay'
      puts 'Sorry, that is not a valid option.'
    end
    answer
  end
end

class Dealer < Participant
  def initialize
    super
    @name = 'Dealer'
  end

  def shows_total
    values = hand.map { |card| card[1] }
    sum = 0
    values[1..-1].each do |value|
      sum += 11 if value == 'Ace'
      sum += 10 if value.to_i == 0
      sum += value.to_i
    end

    # adjusts ace to 1 if sum > 21 and accounts for multiple aces with count
    values.select { |card| card == 'Ace' }.count.times do
      sum -= 10 if sum > 21
    end
    sum
  end
end

class Deck
  attr_accessor :cards

  SUITS = %w[Hearts Clubs Diamonds Spades]
  VALUES = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]

  def initialize
    @cards = SUITS.product(VALUES).shuffle
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
  end

  def display_welcome_message
    clear
    puts "Welcome to 21!"
  end

  def display_goodbye_message
    puts "Thanks for playing 21!"
  end

  def deal_cards!
    clear
    puts "Alright #{player.name}, let's play 21!"
    puts 'Dealing cards...'
    2.times do
      player.hand << game_deck.cards.pop
      dealer.hand << game_deck.cards.pop
    end
  end

  def joinor(array, delimiter=', ')
    case array.size
    when 2 then array.join(' and ')
    else
      array[-1] = "and #{array.last}"
      array.join(delimiter)
    end
  end

  def format_card(card)
    "#{card[1]} of #{card[0]}"
  end

  def format_gameplay_hand(participant)
    cards = participant.hand.map { |card| format_card(card) }
    if participant == @dealer
      cards[0] = 'HIDDEN'
    end
    joinor(cards)
  end

  def format_result_hand(participant)
    cards = participant.hand.map { |card| format_card(card) }
    joinor(cards)
  end

  def display_table
    puts ''
    puts "Your cards: #{format_gameplay_hand(player)}"
    puts "Card total: #{player.cards_total} "
    puts
    puts "Dealer: #{format_gameplay_hand(dealer)}."
    puts "Dealer shows: #{dealer.shows_total}."
    puts ''
  end

  # rubocop:disable Metrics/AbcSize
  def player_turn
    loop do
      player_choice = player.hit_or_stay?
      clear
      if player_choice == 'hit'
        player.hit!(game_deck.cards)
        puts "You drew the #{format_card(player.hand.last)}."
        display_table
      end

      if player_choice == 'stay'
        player.stay
        break
      elsif player.busted?
        puts "#{player.name} busts."
        break
      end
    end
  end

  def dealer_turn
    puts ' '
    puts "#{dealer.name}'s turn..."
    puts "Dealer shows hidden card..."
    puts "Dealer cards: #{format_result_hand(dealer)}"
    puts "Dealer total: #{dealer.cards_total}"
    puts ' '
    loop do
      break if dealer.cards_total >= 17 || player.busted?
      dealer.hit!(game_deck.cards)
      puts "#{dealer.name} draws the #{format_card(dealer.hand.last)}."
      puts "Dealer total: #{dealer.cards_total}"
    end

    dealer.busted? ? (puts 'Dealer busts.') : dealer.stay
  end

  def winner?
    if dealer.busted?
      @winner = player.name
    elsif player.busted?
      @winner = dealer.name
    elsif player.cards_total > dealer.cards_total
      @winner = player.name
    elsif dealer.cards_total > player.cards_total
      @winner = dealer.name
    else
      @winner = "nobody! It's a tie"
    end
  end
  # rubocop:enable Metrics/AbcSize

  def show_result
    puts ' '
    puts '----------Results----------'
    puts "#{@player.name}:"
    puts "Cards: #{format_result_hand(player)}"
    puts "Total: #{@player.cards_total}."
    puts ' '
    puts "#{@dealer.name}:"
    puts "Cards: #{format_result_hand(@dealer)}"
    puts "Total: #{@dealer.cards_total}."
    puts ' '
    puts "And the winner is... #{@winner}!"
  end

  def play_again?
    puts'---------------------------'
    puts 'Would you like to play again?'
    answer = gets.chomp.downcase
    answer.downcase.start_with?('y')
  end

  def reset
    @game_deck = Deck.new
    @winner = nil
    player.hand = []
    dealer.hand = []
    clear
  end

  def clear
    system('clear') || system('cls')
  end

  def start
    # the sequence of steps to execute game play
    loop do
      deal_cards!
      display_table
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
