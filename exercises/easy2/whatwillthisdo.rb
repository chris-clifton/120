class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'Byebye'
  end
end

thing = Something.new
puts Something.dupdata #=> 'Byebye'
puts thing.dupdata #=> 'HelloHello'