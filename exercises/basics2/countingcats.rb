class Cat
  
  @@number_of_cats = 0
  
  def initialize
    @@number_of_cats += 1
  end

  def self.total
    puts @@number_of_cats
  end
end

smithers = Cat.new
scratchy = Cat.new

Cat.total