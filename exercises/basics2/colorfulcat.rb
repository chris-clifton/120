class Cat

  attr_reader :name

  COLOR = 'purple'

  def initialize(name)
    @name = name
    greet
  end

  def greet
    puts "Hello, my name is #{name} and I'm a #{COLOR} cat!"
  end

end

scratchy = Cat.new('Scratchy')

