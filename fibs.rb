require 'bigdecimal'
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
  n > 1 ? [a] + fibs_rec(n-1, b, a+b) : [a]
end

def fibs_fun(n)
  (1..n).to_a.map { |i| fib_fun(i) }
end

def fib(n)
  fibs(n)[-1]
end

def fib_rec(n)
  fibs_rec(n)[-1]
end

def time_trial
  n = 2500
  time_itr = Benchmark.measure do
    (1..n).each { |i| fibs(i) }
  end

  time_rec = Benchmark.measure do
    (1..n).each { |i| fibs_rec(i) }
  end

  puts "Iteration time:"
  puts time_itr

  puts "Recursion time:"
  puts time_rec
end
