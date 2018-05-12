require_relative 'node'

class LinkedList
  attr_reader :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(el)
    new_tail = Node.new(el)
    if empty?
      @head = new_tail
      @tail = new_tail
    else
      @tail.next = new_tail
      @tail = new_tail
    end
    @size += 1
  end

  def prepend(el)
    new_head = Node.new(el)
    if empty?
      @head = new_head
      @tail = new_head
    else
      new_head.next = @head
      @head = new_head
    end
    @size += 1
  end

  def pop
    return nil if empty?
    if @size == 1
      tmp = @head
      clear
      return tmp
    end
    old_tail = @tail
    @tail = node_at(@size - 2)
    @tail.next = nil
    @size -= 1
    old_tail.value
  end

  def tail
    empty? ? nil : @tail.value
  end

  def head
    empty? ? nil : @head.value
  end

  def at(index)
    node = node_at(index)
    node ? node.value : nil
  end

  def insert_at(index, value)
    return nil if index > @size
    new_node = Node.new(value)
    prv_node = nil
    cur_node = @head
    index.times do
      prv_node = cur_node
      cur_node = cur_node.next
    end
    if prv_node
      prv_node.next = new_node
    else
      @head = new_node
    end
    @tail = new_node if cur_node.nil?
    new_node.next = cur_node
    @size += 1
  end

  def remove_at(index)
    return nil if index >= @size
    prv_node = nil
    cur_node = @head
    index.times do
      prv_node = cur_node
      cur_node = cur_node.next
    end
    if prv_node
      prv_node.next = cur_node.next
    else
      @head = cur_node.next
    end
    @tail = prv_node if cur_node.next.nil?
    @size -= 1
    cur_node.value
  end

  def contains?(value)
    !!find(value)
  end

  def find(value)
    cur_node = @head
    @size.times do |i|
      return i if cur_node.value == value
      cur_node = cur_node.next
    end
    nil
  end

  def empty?
    @head.nil?
  end

  def clear
    @head = nil
    @tail = nil
    @size = 0
  end

  def to_s
    s = ''
    cur_node = @head
    @size.times do
      s << "( #{cur_node.value} ) -> "
      cur_node = cur_node.next
    end
    s << "nil"
  end
  
  private

  def node_at(index)
    return nil if index >= @size
    cur_node = @head
    index.times do
      cur_node = cur_node.next
    end
    cur_node
  end
end
