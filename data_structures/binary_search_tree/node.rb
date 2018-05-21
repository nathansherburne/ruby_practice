class Node
  attr_reader :key
  attr_accessor :left
  attr_accessor :right
  attr_accessor :parent
  attr_accessor :height

  def initialize(key)
    @key = key
    @left = nil
    @right = nil
    @parent = nil
    @height = 0
  end

  def <=>(other)
    @key <=> other.key
  end
end
