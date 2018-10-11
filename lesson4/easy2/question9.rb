class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules and stuff
  end
end

# What would happen if we added a play method to Bingo class keeping in mind there is already a play method in Game?

# The Bingo's play method would be called for every instance of the Bingo class.