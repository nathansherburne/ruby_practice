require 'benchmark'

def append_push
  arr = []
  (1..1000).each { |i| arr.push(i) }
end

def append_arrows
  arr = []
  (1..1000).each { |i| arr << i }
end

def append_insert
  arr = []
  (1..1000).each { |i| arr.insert(-1, i) }
end

time_push = Benchmark.measure do
  100000.times { append_push }
end

time_arrows = Benchmark.measure do
  100000.times { append_arrows }
end

time_insert = Benchmark.measure do
  100000.times { append_insert }
end

puts "Push time   #{time_push}"
puts "Arrow time: #{time_arrows}"
puts "Insert time: #{time_insert}"
