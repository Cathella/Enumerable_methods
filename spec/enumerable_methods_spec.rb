require_relative '../Enumerable.rb'

describe Enumerable do
  let(:number_array) { [1, 2, 3, 4, 5] }
  let(:string_array) { ['cathy', 'ella', 'ade', 'letty', 'anna'] }
  let(:number_array_with_nil) { [1, 2, 3, 4, nil] }
  let(:string_array_with_numbers) { [1, 'ella', 2, 'ade', 3] }
  let(:empty_array) { [] }
  let(:ranges) { (1..10) }
end
