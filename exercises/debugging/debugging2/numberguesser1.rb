class GuessingGame

  attr_reader :guesses_remaining
  attr_accessor :current_guess

  def initialize
    @magic_number = rand(100)
    @guesses_remaining = 7
    @current_guess = nil
  end

  def display_remaining_guesses
    "You have #{guesses_remaining} remaining."
  end

  def get_guess
    puts "Enter a number between 1 and 100:"
    loop do
      current_guess = gets.chomp.to_i
      if current_guess > 100 || currrent_guess < 0
        puts "Invalid guess. Enter a number between 1 and 100:"
      elsif curren
      end
    end
  end

  def valid_guess?
    

end

new_game = GuessingGame.new
p new_game