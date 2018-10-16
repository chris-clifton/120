class FixedArray

  def initialize(size)
    @size = size
    @array = Array.new(size)
  end

  def [](index)
    @array.fetch(index)
  end

  def []=(index, value)
    @array[index] = value
  end

  def to_a
    @array.clone
  end

  def to_s
    to_a.to_s
  end
end

