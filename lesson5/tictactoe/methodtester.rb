class Player
  RANDOM_AI_NAMES = ['stupidface', 'etc', 'hola']
end


def choose_human_name
  puts "What is your name?"
  name = nil
  wrong_answer_counter = 0
  loop do
    name = gets.chomp
    break unless name.empty? || name.length > 20
    wrong_answer_counter += 1
    puts "Sorry, that is not a valid name."
    if wrong_answer_counter >= 3
      name = Player::RANDOM_AI_NAMES.sample
      puts "Too slow- #{name} it is!"
    end
  end
  name
end

choose_human_name

