class BinarySearchTree
  def initialize
    @root = nil
    @size = 0
  end

  def add(value)
    node = Node.new(value)
    if empty?
      @root = node
    else
      add_rec(@root, node)
    end
    size += 1
  end

  def build_tree(arr)
    arr.each { |x| add(x) }
  end

  def breadth_first_search(value)
    queue = [@head]
    while (cur = queue.shift)
      return cur if cur.value == value
      queue << cur.left
      queue << cur.right
    end
    nil
  end

  def depth_first_search(value)
    stack = [@head]
    while (cur = stack.pop)
      return cur if cur.value == value
      queue << cur.right
      queue << cur.left
    end
    nil
  end


  private

  def add_rec(root, node)
    case node <=> root
    when -1, 0
      if root.left
        add_rec(root.left, node)
      else
        root.left = node
        node.parent = root
      end
    when 1
      if root.right
        add_rec(root.right, node)
      else
        root.right = node
        node.parent = root
      end
    end
  end
end
