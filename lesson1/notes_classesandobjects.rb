# class GoodDog
#   attr_accessor :name, :height, :weight

#   def initialize(n, h, w)
#     @name = n
#     @height = h
#     @weight = w
#   end

#   def speak
#     "#{name} says arf!"
#   end

#   def change_info(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end

#   def info
#     "#{name} weighs #{weight} and is #{height} tall."
#   end
# end

# sparky = GoodDog.new("Sparky", 12, 10)
# puts sparky.info
# sparky.change_info("Spartacus", 15, 20)
# puts sparky.info


class MyCar

  attr_accessor :color, :year, :model
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def slow_down(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are currently going #{@current_speed} mph."
  end

  def self.gas_milage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas."
  end

  def shut_off
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "You have painted your #{model} #{color}.  Sick!"
  end

  def specs
    puts "My #{@model} is a #{@color} #{@year}."
  end

  def to_s
    puts "My car is a #{color} #{year} #{model}."
  end

end

subaru = MyCar.new(2011, 'silver', 'Forester')

subaru.specs
MyCar.gas_milage(16.9, 389)

puts subaru
