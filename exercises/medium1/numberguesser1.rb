class GuessingGame

  attr_reader :magic_number
  attr_accessor :current_guess, :guesses_remaining

  def initialize
    @magic_number = rand(100)
    @guesses_remaining = 7
    @current_guess = nil
  end

  def display_remaining_guesses
    "You have #{guesses_remaining} remaining."
  end

  def get_guess
    puts 'Enter a number between 1 and 100:'
    loop do
      break if guesses_remaining == 0
      current_guess = gets.chomp.to_i
      if current_guess > 100 || current_guess <= 0
        puts 'Invalid guess. Enter a number between 1 and 100:'
      elsif current_guess > magic_number
        @guesses_remaining -= 1
        puts 'Your guess is too high.'
      elsif current_guess < magic_number
        @guesses_remaining -= 1
        puts 'Your guess is too low.'
      else
        puts "That's the number!"
        break
      end
    end

    def show_result
      if guesses_remaining > 0
        puts 'You won!'
      else
        puts 'You lost!'
      end
    end
  end

  def play
    display_remaining_guesses
    get_guess
    show_result
  end     

end

new_game = GuessingGame.new
new_game.play