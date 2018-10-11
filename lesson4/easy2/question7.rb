class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain @@cats_count variable and how it works.  What code would you need to write to test theory?

# @@cats_count is a classs variable.  The class initialize method, which is automatically executed every time
# a new instance of the Cat class is instantiated will increment this counter by 1 as seen by the code on line 7.
# the self.cats_count method is a way to retreive the value of the class variable @cats_count.

# Test code

pussycat = Cat.new('annoying')
Smithers = Cat.new('scratchy cat')
p Cat.cats_count