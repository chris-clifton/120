# class Participant
#   attr_accessor :hand

#   def initialize
#     @hand = []
#   end

#   def hit
#     # add random card from deck to player hand
#   end

#   def stay
#     # shouldn't do much
#   end

#   def busted?
#     # if card total > 21 then busted
#   end

#   def display_cards
#     self.hand
#   end
# end

# class Player < Participant
#   attr_accessor :name
#   def initialize
#     super
#     @name = pick_a_name
#   end

#   def pick_a_name
#     puts "Hello Player, what is your name?"
#     answer = nil
#     loop do
#       answer = gets.chomp
#       break unless answer.strip.empty?
#       puts "Please choose a valid name."
#     end
#     self.name = answer
#   end
# end
# chris = Player.new


def dealer_won?
  !dealer.busted? && (player.busted? || dealer.cards_total > player.cards_total)  
end

def player_won?
  !player.busted? && (dealer.busted || player.cards_total > dealer.cards_total)
end

def tie?
  !dealer_won? && !player_won?
end

