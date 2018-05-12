require_relative 'node_dbl'

class Queue_ll
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def push(el)
    new_head = Node.new(el)
    if empty?
      @tail = new_head
    else
      new_head.next = @head
      @head.prev = new_head
    end
    @head = new_head
    @size += 1
  end

  def pop
    return nil if empty?
    old_tail = @tail
    @tail = old_tail.prev
    @head = nil if old_tail.prev.nil?
    @size -= 1
    old_tail.val
  end

  def empty?
    @head.nil?
  end

  def size
    @size
  end
end

