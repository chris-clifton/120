module Swim
  def swim
    "swimming!"
  end
end

class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Cat < Animal
  def speak
    'meow!'
  end
end

class Dog < Animal

  include Swim

  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end
end

class Fish < Animal
  include Swim
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

p Dog.ancestors
p Fish.ancestors
p Bulldog.ancestors