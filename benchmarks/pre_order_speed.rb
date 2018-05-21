require_relative '../data_structures/binary_search_tree/bst'
require 'benchmark'

bst = BinarySearchTree.new
values = (1..100_000_000).to_a.shuffle.take(1_000_000)
values.each { |v| bst.add(v) }

time_rec = Benchmark.measure do
  bst.pre_order_traversal2 { |n| n.key }
end

time_itr = Benchmark.measure do
  bst.pre_order_traversal1 { |n| n.key }
end

puts "Recursive time: #{time_rec}"
puts "Iterative time: #{time_itr}"
