module Enumerable
    def my_each
        for el in self do yield el end
        self
    end

    def my_each_with_index
        i = 0
        for el in self
            yield el,i
            i += 1
        end
        self
    end

    def my_select
        out = []
        self.my_each { |el| out << el if yield el }
        out
    end

    def my_all?
        if block_given?
            self.my_each { |el| return false unless yield el }
        else
            self.my_each { |el| return false unless el }
        end
        true
    end

    def my_any?
        if block_given?
            self.my_each { |el| return true if yield el }
        else
            self.my_each { |el| return true if el }
        end
        false
    end

    def my_none?
        !(my_any?)
    end

    def my_count(x=nil)
        count = 0
        if block_given?
            self.my_each { |el| count += 1 if yield el }
        elsif x
            self.my_each { |el| count += 1 if el == x }
        else
            count = self.length
        end
        count
    end

    def my_map(&block)
        out = []
        if block
            self.my_each { |el| out << block.call(el) }
        elsif block_given?
            self.my_each { |el| out << (yield el) }
        else
            out = self
        end
        out
    end

    def my_inject(memo=nil)
        i = 0
        if memo == nil
            memo = self[0]
            i += 1
        end
        self[i..-1].my_each { |el| memo = yield(memo, el) } 
        memo
    end
end























