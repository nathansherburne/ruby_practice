def bubble_sort(arr)
    changed = true
    while changed
        changed = false
        for i in 0...arr.length-1
            a = arr[i]
            b = arr[i+1]
            r = a - b
            if r > 0
                changed = true
                arr[i] = b
                arr[i+1] = a
            end
        end
    end
    return arr
end

def bubble_sort_by(arr)
    changed = true
    while changed
        changed = false
        for i in 0...arr.length-1
            a = arr[i]
            b = arr[i+1]
            r = yield(a,b)
            if r > 0
                changed = true
                arr[i] = b
                arr[i+1] = a
            end
        end
    end
    return arr
end
