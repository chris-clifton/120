class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello, my name is #{name}!"
  end
end

kitty = Cat.new('Scratchy')
kitty.greet
kitty.name = 'Itchy'
kitty.greet