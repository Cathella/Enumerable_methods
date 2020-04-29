module Enumerable
    def my_each
        return to_enum unless block_given?
        length.times do |i|
            yield(self[i])
        end
    end

    def my_each_with_index
        return to_enum unless block_given?
        length.times do |i|
            yield(self[i], i)
        end
    end

    def my_select
        return to_enum unless block_given?
        arr = []
        length.times do |i|
            arr.push(self[i]) if yield(self[i])
        end
        arr
    end

    def my_all?()
        result = true
        if block_given?
            my_each { |i| result = false unless yield(i) }
        else
            my_each { |i| result = false unless i }
        end 
        result
    end

    def my_any?(arg = nil)
        result = false
        if arg
            my_each { |i| result = true if i.is_a?(arg) }
        elsif block_given?
            my_each { |i| result = true if yield(i) }
        else
            my_each { |i| result = true if i }
        end
        result
    end

    def my_none?
        result = true
        if block_given?
            my_each { |i| result = false if yield(i) }
        else
            my_each { |i| result = false if i }
        end 
        result
    end

    def my_count
        # your code here
    end

    def my_map
        # your code here
    end

    def my_inject
        # your code here
    end
end