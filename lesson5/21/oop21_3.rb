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
      sum += 10 if value.to_i == 0 && value != 'Ace'
      sum += value.to_i
    end

    # adjusts ace to 1 if sum > 21 and accounts for multiple aces with count
    values.select { |card| card == 'Ace' }.count.times do
      sum -= 10 if sum > 21
    end
    sum
  end

  def card_total_21?
    cards_total == 21
  end

  def show_new_card
    puts "#{name} drew the #{format_card(hand.last)}."
  end

  def format_card(card)
    "#{card[1]} of #{card[0]}"
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

  def choose_hit_or_stay
    puts 'Would you like to hit or stay?'
    answer = nil
    loop do
      answer = gets.chomp.downcase
      case answer
      when 'h' then answer = 'hit'
      when 's' then answer = 'stay'
      end
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

  def hidden_total
    values = hand.map { |card| card[1] }
    sum = 0
    values[1..-1].each do |value|
      sum += 11 if value == 'Ace'
      sum += 10 if value.to_i == 0 && value != 'Ace'
      sum += value.to_i
    end

    # adjusts Ace to 1 if sum > 21 and accounts for multiple Aces with count
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

  def display_initial_deal_message
    clear
    puts "Alright #{player.name}, let's play 21!"
    puts "Dealing cards.."
  end

  def deal_cards!
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
    puts "Dealer shows: #{dealer.hidden_total}."
    puts ''
  end

  def player_turn
    loop do
      break if player.busted? || player.card_total_21?
      player_choice = player.choose_hit_or_stay
      if player_choice == 'stay'
        player.stay
        break
      else
        player.hit!(game_deck.cards)
        player.show_new_card
        display_table
      end
    end
  end

  def display_dealer_turn_message
    puts ' '
    puts "Dealer's turn..."
    puts "Dealer shows hidden card..."
    puts "Dealer cards: #{format_result_hand(dealer)}"
    puts "Dealer total: #{dealer.cards_total}"
    puts ' '
  end

  def dealer_turn
    loop do
      break if dealer.cards_total >= 17 || player.busted?
      dealer.hit!(game_deck.cards)
      dealer.show_new_card
      puts "Dealer total: #{dealer.cards_total}"
    end
  end

  def show_busted
    if player.busted?
      puts "#{player.name} busted! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "#{dealer.name} busted! #{player.name} wins!"
    end
  end

  def dealer_won?
    !dealer.busted? &&
      (player.busted? || dealer.cards_total > player.cards_total)
  end

  def player_won?
    !player.busted? &&
      (dealer.busted? || player.cards_total > dealer.cards_total)
  end

  def tie?
    !dealer_won? && !player_won?
  end

  def determine_winner
    if player_won?
      @winner = player.name
    elsif dealer_won?
      @winner = dealer.name
    else
      @winner = "nobody, it's a tie!"
    end
  end

  def show_result
    puts ' '
    puts '----------Results----------'
    puts "#{@player.name}:"
    puts "Cards: #{format_result_hand(player)}"
    puts "Total: #{@player.cards_total}."
    puts ' '
    puts "Dealer:"
    puts "Cards: #{format_result_hand(@dealer)}"
    puts "Total: #{@dealer.cards_total}."
    puts ' '
    puts "And the winner is... #{@winner}!"
  end

  def play_again?
    puts'---------------------------'
    puts 'Would you like to play again?'
    answer = ''
    choices = %w[y yes n no]
    loop do
      answer = gets.chomp.downcase
      break if choices.include?(answer)
      puts "Please enter yes or no."
    end
    answer == ('y' || 'yes') ? true : false
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
      display_initial_deal_message
      deal_cards!
      display_table

      player_turn
      if player.busted?
        show_busted
        play_again? ? reset : break
      end

      display_dealer_turn_message
      dealer_turn
      if dealer.busted?
        show_busted
        play_again? ? reset : break
      end

      determine_winner
      show_result
      play_again? ? reset : break
    end
    display_goodbye_message
  end
end

Game.new.start
