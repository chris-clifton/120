class Employee
  attr_accessor :name, :serial_number, :type

  def initialize(name, serial_number, type)
    @name = name
    @serial_number = serial_number
    @type = type
  end

  def to_s
    puts "Name: #{name}"
    puts "Type: #{type}"
    puts "Serial number: #{serial_number}"
  end
end

class PartTimeEmployee < Employee
end

class FullTimeEmployee < Employee
  include Vacationable
  
  def initialize(name, serial_number, type, vacation_days, desk)
    super(name, serial_number, type)
    @vacation_days = vacation_days
    @desk = desk
  end

end

class Employer < Employee
  attr_accessor :name, :serial_number, :type, :vacation_days, :desk

  include Vacationable
  include Delegatable

  def initialize(name, serial_number, type, vacation_days, desk)
    super(name, serial_number, type)
    @vacation_days = vacation_days
    @desk = desk
  end

end

# is this class necessary?
class Staff < Employee
end

module Vacationable
  def take_vacation
    puts"#{self.name} has #{self.vacation_days} days of vacation."
  end
end

module Delegatable
  def delegate
  end
end



class Manager < Employer
  include Vacationable
  include Delegatable

  def initialize

  vacation = 14 days
  desk = regular private office
end

class Executives < Employer
  include Vacationable
  include Delegatable

  vacation = 20 days
  desk = corner office
end