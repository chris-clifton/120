class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# What is .self refering to on line 10?

# It's refering to the instance of the Cat class that calls it.  For example, pussycat.make_one_year_older 
# and pussycat would be the .self.