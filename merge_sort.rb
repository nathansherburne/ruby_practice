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
  m << (i < a.length ? a[i] : b[j]) # Handles end case.
end
