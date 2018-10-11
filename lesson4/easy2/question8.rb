class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #some rules
  end
end

# What can we add to bingo to make it inhereit the 'play' method from Game?

# Added inheritance from Game with '< Game'