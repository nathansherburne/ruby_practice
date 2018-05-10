require 'benchmark'

def fibs(n, a = 0, b = 1)
  f = [a,b]
  (n-2).times do
    tmp = b
    b += a
    a = tmp
    f << b
  end
  f
end

def fibs_rec(n, a = 0, b = 1)
  n > 1 ? [a] + [fibs_rec(n-1, b, a+b)] : [a]
end

time_itr = Benchmark.measure do
  (1..2000).each { |n| fibs(n) }
end

time_rec = Benchmark.measure do
  (1..2000).each { |n| fibs_rec(n) }
end

puts "Iteration time:"
puts time_itr

puts "Recursion time:"
puts time_rec
