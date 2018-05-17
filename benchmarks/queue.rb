require 'benchmark'
require_relative '../data_structures/queue_ll'
require_relative '../data_structures/queue_arr'

letters = ['a'] * 10_000
n = 1_000

q = Queue_ll.new

time_push_ll = Benchmark.measure do
  n.times do
    letters.each { |c| q.push(c) }
  end
end

time_pop_ll = Benchmark.measure do
  until q.empty?
    q.pop
  end
end

q = Queue_arr.new

time_push_arr = Benchmark.measure do
  n.times do
    letters.each { |c| q.push(c) }
  end
end

time_pop_arr = Benchmark.measure do
  until q.empty?
    q.pop
  end
end

puts "ll push: #{time_push_ll}"
puts "arr push: #{time_push_arr}"
puts "ll pop: #{time_pop_ll}"
puts "arr pop: #{time_pop_arr}"
