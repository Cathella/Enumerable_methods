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
            my_each { |obj| result = false unless yield(obj) }
        else
            my_each { |obj| result = false unless obj }
        end 
        result
    end

    def my_any?(arg = nil)
        result = false
        if arg
            my_each { |obj| result = true if obj.is_a?(arg) }
        elsif block_given?
            my_each { |obj| result = true if yield(obj) }
        else
            my_each { |obj| result = true if obj }
        end
        result
    end

    def my_none?
        # your code here
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