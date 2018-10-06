# # module Towable
# #   def can_tow?(pounds)
# #     pounds < 2000 ? true : false
# #   end
# # end

# # class Vehicle

# #   attr_accessor :color, :year, :model

# #   @@number_of_vehicles = 0

# #   def initialize(year, color, model)
# #     @year = year
# #     @color = color
# #     @model = model
# #     @current_speed = 0
# #     @@number_of_vehicles += 1
# #   end

# #   def self.gas_milage(gallons, miles)
# #     puts "#{miles / gallons} miles per gallon of gas."
# #   end

# #   def self.print_number_vehicles
# #     puts @@number_of_vehicles
# #   end

# #   def age
# #     puts "Your #{self.model} is #{years_old} years old."
# #   end  

# #   def speed_up(number)
# #     @current_speed += number
# #     puts "You push the gas and accelerate #{number} mph."
# #   end

# #   def slow_down(number)
# #     @current_speed -= number
# #     puts "You push the brake and decelerate #{number} mph."
# #   end

# #   def current_speed
# #     puts "You are currently going #{@current_speed} mph."
# #   end

# #   def shut_off
# #     @current_speed = 0
# #     puts "Let's park this bad boy!"
# #   end

# #   def spray_paint(color)
# #     self.color = color
# #     puts "You have painted your #{model} #{color}.  Sick!"
# #   end

# #   def specs
# #     puts "My #{@model} is a #{@color} #{@year}."
# #   end

# #   private

# #   def years_old
# #     Time.now.year - self.year
# #   end

# # end

# # class MyCar < Vehicle
# #   NUMBER_OF_DOORS = 4
# # end

# # class MyTruck < Vehicle
# #   NUMBER_OF_DOORS = 2
# #   include Towable
# # end

# # Tacoma = MyTruck.new(2018, "white", "Tacoma Pro")
# # Forester = MyCar.new(2011, "silver", "Forester")
# # Ram = MyTruck.new(1971, "blue", "Dodge Ram")

# # Tacoma.specs
# # Tacoma.age
# # Tacoma.speed_up(50)
# # Tacoma.current_speed
# # puts ""
# # Ram.specs
# # Ram.age
# # Ram.speed_up(10)
# # Ram.slow_down(5)
# # Ram.current_speed 
# # puts ""
# # Forester.specs
# # Forester.age
# # Forester.speed_up(10)
# # Forester.current_speed
# # Forester.shut_off
# # Forester.current_speed
# # Forester.spray_paint("black")
# # Forester.specs

# class Student
#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end

#   def better_grade_than?(other_student)
#     grade > other_student.grade
#   end

#   protected

#   def grade
#     @grade
#   end
# end

# joey = Student.new("Joey", 90)
# bob = Student.new("Bob", 84)
# puts "Well done!" if joey.better_grade_than?(bob)

class SecretThing

  def share_secret
    "The secret is #{secret}"
  end

  private

  def secret
    "shhh.. it's a secret!!"
  end
end

p SecretThing.new.share_secret # => "The secret is shhh.. it's a secret!!"