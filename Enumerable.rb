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

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def my_all?(arg = nil)
    result = true
    my_each do |i|
      if result
        if arg.is_a?(Class) || arg.is_a?(Regexp)
          result = i.is_a?(arg) unless arg.is_a?(Regexp)
          result = !i.match(arg).nil? if arg.is_a?(Regexp)
        elsif arg
          result = i == arg1
        elsif block_given?
          result = false unless yield(i)
        else
          result = false unless i
        end
      end
    end
    result
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def my_any?(arg = nil, &block)
    result = false
    my_each do |i|
      if arg.is_a?(Class) || arg.is_a?(Regexp)
        result ||= i.is_a?(arg) unless arg.is_a?(Regexp)
        result ||= !i.match(arg).nil? if arg.is_a?(Regexp)
      elsif arg
        result = true if i == arg
      elsif block_given?
        result ||= block.call(i) unless result
      elsif i || result
        result = true
      end
    end
    result
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
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

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def my_inject(arg = nil, arg2 = nil)
    result = is_a?(Range) ? min : self[0]
    if arg2.is_a?(Symbol) || arg2.is_a?(String)
      my_each_with_index { |element, i| result = result.send(arg2, element) if i.positive? }
      result = result.send(arg2, arg)
    elsif block_given?
      my_each_with_index { |element, i| result = yield(result, element) if i.positive? }
      result = yield(result, arg) if arg
    elsif arg.is_a?(Symbol) || arg.is_a?(String)
      my_each_with_index { |element, i| result = result.send(arg, element) if i.positive? }
    end
    result
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def multiply_els(arr)
    arr.my_inject do |x, y|
      x * y
    end
  end
end