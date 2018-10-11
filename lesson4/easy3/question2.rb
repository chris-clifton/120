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

# Hello.hi gives an error message.  How would you fix this?

# Instantiate an instance of the Hello class and then call the 'hi' method on it.

# You could also write a class method for Hello that did the same thing