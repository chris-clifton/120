module Vacationable
  def take_vacation
    "I have #{self.vacation_days} days of vacation."
  end
end

module Delegatable
  def delegate
    "I can delegate work"
  end
end

class Employee
  attr_accessor :name, :serial_number, :type
  def initialize(name, serial_number, type)
    @name = name
    @serial_number = serial_number
    @type = type
  end

  def to_s
    "Name: #{name}\n" +
    "Type: #{type}\n" +
    "Serial number: #{serial_number}\n"
  end
end

class PartTime < Employee
end

class FullTime < Employee
  attr_accessor :vacation_days, :desk

  include Vacationable

  def initialize(name, serial_number, type)
    super(name, serial_number, type)
    @vacation_days = 10
    @desk = 'cubicle'
  end

  def to_s
    super +
    "Vacation days: #{vacation_days}\n" +
    "Desk: #{desk}"
  end
end

class Manager < FullTime
  include Delegatable

  def initialize(name, serial_number, type)
    super
    @vacation_days = 14
    @desk = 'private office'
  end
end

class Executive < Manager
  def initialize(name, serial_number, type)
    super
    @vacation_days = 20
    @desk = 'corner office'
  end
end