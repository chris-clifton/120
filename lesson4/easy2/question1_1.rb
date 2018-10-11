<<<<<<< HEAD
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is result of following two lines?
oracle = Oracle.new
oracle.predict_the_future

#=> "You will[eat a nice lunch || take a nap soon || stay at work late]"
=======

>>>>>>> 7a0bd2870dcb815d98d3620187805606be70ed79
