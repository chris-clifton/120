class Machine
  # attr_writer :switch

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def status
    "The state of the switch is #{switch}."
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

computer = Machine.new
p computer.start
p computer.status
p computer.stop
p computer.status
