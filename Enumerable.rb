module Enumerable
    def my_each
        return to_enum unless block_given?

        length.times do |i|
            yield(self[i])
        end
    end

    def my_each_with_index
        # your code here
    end

    def my_select
        # your code here
    end

    def my_all?
        # your code here
    end

    def my_any?
        # your code here
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