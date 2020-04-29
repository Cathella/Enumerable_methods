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

    def my_all?
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

    def my_count(arg = nil)
        result = 0
        if block_given?
            my_each do |i|
                result += 1 if yield(i)
            end
        elsif arg
            my_each do |i|
                result += 1 if i == arg
            end
        else
            result = length
        end 
        result
    end

    def my_map(proc = nil)
        return to_enum unless block_given?
        arr = []
        if proc.nil?
            length.times do |i|
                arr.push(yield(self[i]))
            end
        else
            length.times do |i|
                arr.push(proc.call(self[i]))
            end
        end
        arr
    end

    def my_inject(arg1 = nil, arg2 = nil)
        if block_given? && arg1
            result = arg1
            my_each do |i|
                result = yield(result, i)
            end 
        elsif block_given? && !arg1
            result = self[0]
            my_each_with_index do |i, x|
                result = yield(result, i) unless x.zero?
            end
        else
            result = arg1
            operation = arg2.to_proc
            my_each do |i|
                result = operation.call(result, i)
            end
        end 
        result
    end

    def multiply_els(arr)
        arr.my_inject do |x, y|
            x*y
        end
    end
end