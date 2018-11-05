class Machine
  
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def info
    "The #{name} is currently turned #{switch}."
  end

private
attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end


computer = Machine.new('computer')
p computer.start
p computer.info
p computer.stop
p computer.info

router = Machine.new('router')
p router.start
p router.info