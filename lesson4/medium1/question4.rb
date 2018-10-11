class Greeting
  def greet(string)
    puts string
  end

end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    ("Goodbye")
  end
end

