class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# case 1
hello = Hello.new
hello.hi #=> "Hello"

# case 2
hello = Hello.new
hello.bye #=> undefined method 'bye'

# case 3
hello = Hello.new
p hello.greet #=> No Argument Error, given 0 expecting 1

# case 4
hello = Hello.new
hello.greet("Goodbye") #=> "Goodbye"

# case 5
Hello.hi #=> undefined method 'hi' for Hello class