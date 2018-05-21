require_relative 'node'

class BinarySearchTree
  attr_reader :size

  def initialize
    @root = nil
    @size = 0
  end

  def add(key)
    node = Node.new(key)
    if empty?
      @root = node
    else
      add_recursive(@root, node)
    end
    @size += 1
  end

  def search(key)
    search_recursive(@root, key)
  end

  def build_tree(arr)
    arr.each { |x| add(x) }
  end

  def empty?
    @root.nil?
  end

  def height
    @root.height
  end

  def sorted
    sorted = []
    in_order_traversal { |node| sorted << node.key }
    sorted
  end

  def in_order_traversal(root = @root, &block)
    in_order_traversal(root.left, &block) if root.left
    yield root
    in_order_traversal(root.right, &block) if root.right
  end 

  def pre_order_traversal(&block)
    pre_order_traversal1(&block) # Marginally faster than recursive version.
  end

  def pre_order_traversal1
    stack = [@root]
    until stack.empty?
      node = stack.pop
      yield node
      stack << node.right if node.right
      stack << node.left if node.left
    end
  end

  def pre_order_traversal2(root = @root, &block)
    yield root
    pre_order_traversal2(root.left, &block) if root.left
    pre_order_traversal2(root.right, &block) if root.right
  end

  def post_order_traversal(root = @root, &block)
    post_order_traversal(root.left, &block) if root.left
    post_order_traversal(root.right, &block) if root.right
    yield root
  end

  def breadth_first_traversal
    queue = [@root]
    until queue.empty?
      node = queue.shift
      yield node
      queue << node.left if node.left
      queue << node.right if node.right
    end
  end

  def search_recursive(root, key)
    cmp = key <=> root.key
    if cmp == 0
      return root
    elsif cmp == -1 && root.left
      search_recursive(root.left, key)
    elsif cmp == 1 && root.right
      search_recursive(root.right, key)
    else
      nil
    end
  end

  def add_recursive(root, node)
    cmp = node <=> root
    if cmp == -1 && root.left
      add_recursive(root.left, node)
    elsif cmp == 1 && root.right
      add_recursive(root.right, node)
    elsif cmp == 0 && root.right && root.left
      add_recursive(root.left, node)
    elsif (cmp == 0 || cmp == -1) && !root.left
      root.left = node
      node.parent = root
      increment_height(node.parent)
    elsif (cmp == 0 || cmp == 1) && !root.right
      root.right = node
      node.parent = root
      increment_height(node.parent)
    end
  end

  def increment_height(node)
    return if node.nil?
    new_height = [get_height(node.left), get_height(node.right)].max + 1
    if node.height < new_height
      node.height = new_height
      increment_height(node.parent)
    end
  end

  def get_height(node)
    node ? node.height : -1
  end
end
