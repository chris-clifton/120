class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-" + "-" * @message.length + "-+"
  end

  def empty_line
    "| " + " " * @message.length + " |"
  end

  def message_line
    "| #{@message} |"
  end
end

hello = Banner.new('hello')
banner = Banner.new('')
test2 = Banner.new('This is a test banner')

puts banner 
puts hello
puts test2