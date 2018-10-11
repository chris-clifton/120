class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end

# How could we change to_s method to output "I am a tabby cat"

stupidcat = Cat.new('Scratchy')
p stupidcat.to_s