class Node
  attr_accessor :next
  attr_accessor :prev
  attr_reader :val

  def initialize(val)
    @val = val
    @next = nil
    @prev = nil
  end
end
