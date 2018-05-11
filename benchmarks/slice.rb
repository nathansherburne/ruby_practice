require 'benchmark'

def slice_ind(arr)
  a = arr[0..(arr.length/2 - 1)]
  b = arr[(arr.length/2)..-1]
end

def slice_mth(arr)
  a, b = arr.each_slice((arr.length + 1) / 2)
end

arr = (1..1000).to_a

time_ind = Benchmark.measure do
  9_999_999.times { slice_ind(arr) }
end

time_mth = Benchmark.measure do
  9_999_999.times { slice_mth(arr) }
end

puts "Indexing time:     #{time_ind}"
puts "Slice method time: #{time_mth}"
