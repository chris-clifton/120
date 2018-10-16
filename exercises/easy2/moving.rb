module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end


class Person
  include Walkable
  
  attr_reader :name

  def initialize(name)
    @name = name
  end

  # def walk
  #   "#{name} #{gait} forward"
  # end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new('Mike')
puts mike.walk