class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of following two lines?
trip = RoadTrip.new
trip.predict_the_future

# "You will [visit vegas || fly to fiji || romp in Rome]"
# The instance method for roadtrip "overshadows" the method from its superclass Oracle