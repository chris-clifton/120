class Cat  
  attr_writer :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello, my name is #{name}!"
  end
end

itchy = Cat.new('Scratchy')

itchy.greet
itchy.name = 'Luna'
itchy.greet