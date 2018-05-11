require 'benchmark'

def merge_sort(arr)
  return arr if arr.length <= 1
  a = merge_sort(arr[0..(arr.length / 2 - 1)])
  b = merge_sort(arr[(arr.length / 2)..-1])
  merge(a, b)
end

def merge(a, b)
  m = []
  i = 0
  j = 0
  while i < a.length && j < b.length
    top_a = a[i]
    top_b = b[j]
    if top_a <= top_b
      m << top_a
      i += 1
    else
      m << top_b
      j += 1
    end
  end
  m + a[i..-1] + b[j..-1]  # Handles end case.
end

arr = [66, 3, 76, 1, 0, 43, 10534, 32, 6, 5, 4, 3, 2, 7, 77, 73, 10, 11, 12, 54, 0, 1432, 53, 3, 2, 1430, 1400, 1, 5, 77, 12, 3, 65, 63, 18]

time = Benchmark.measure do
  99999.times { merge_sort(arr) }
end

puts time
