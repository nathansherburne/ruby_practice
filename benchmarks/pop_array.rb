require 'benchmark'

n = 10_000_000

# Star method takes orders of magnitude longer.
#arr = (1..n).to_a
# time_star = Benchmark.measure do
#   while arr.length > 1
#     a, *arr = arr
#   end
# end
#puts "Star: #{time_star}"

arr = (1..n).to_a

time_shift = Benchmark.measure do
  while arr.length > 1
    a = arr.shift
  end
end

arr = (1..n).to_a

time_index = Benchmark.measure do
  while arr.length > 1
    a = arr[0]
    arr = arr[1..-1]
  end
end

arr = (1..n).to_a

time_drop = Benchmark.measure do
  i = 0
  while i < arr.length
    a = arr.drop(i)[0]
    i += 1
  end
end

puts "Shift: #{time_shift}"
puts "Index: #{time_index}"
puts "Drop: #{time_drop}"
