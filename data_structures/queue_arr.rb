class Queue_arr
  def initialize
    @arr = []
  end

  def push(el)
    @arr.push(el)
  end

  def pop
    @arr.shift
  end

  def empty?
    @arr.empty?
  end

  def size
    @arr.length
  end
end


