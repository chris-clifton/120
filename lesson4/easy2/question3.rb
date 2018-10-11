module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# How do you find Ruby lookup path?
# How do you find an objects ancestors?

p Orange.ancestors
p HotSauce.ancestors