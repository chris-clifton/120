In the last question we had a module called Speed which contained a go_fast method. We included this module in the Car class as shown below.

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end
```

When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

```ruby
>> small_car = Car.new
>> small_car.go_fast
I am a Car and going super fast!
```
Calling `self`  on line 6 refers to the calling object and the `.class` method asks the calling object's class, which is Car.