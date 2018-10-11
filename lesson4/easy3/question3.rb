class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# How do we create two different instances of this class?

stupidcat1 = AngryCat.new(5, 'Scratchy')
stupidcat2 = AngryCat.new(6, 'Mike Hat')

p stupidcat1
p stupidcat2