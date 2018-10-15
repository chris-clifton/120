class Person
  attr_reader :phone_number

  def initialize(phone_number)
    @phone_number = phone_number
  end

end

person1 = Person.new(123456789)
puts person1.phone_number

person1.phone_number = 9987654321
puts person.phone_number