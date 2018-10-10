# Which of tehse two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

hot_pizza = Pizza.new("cheese")
orange = Fruit.new("apple")

# You can see the instance variable initialized on line 11 with the '@' symbol.

p hot_pizza.instance_variables
p orange.instance_variables