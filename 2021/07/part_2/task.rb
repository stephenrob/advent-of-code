require 'common/base_task'

class Task < BaseTask

  def run
    start_positions = @input_array[0].split(',').map(&:to_i)

    cheapest = -1

    [*start_positions.min..start_positions.max].each do |i|

      distances = start_positions.map { |s| (s-i).abs }.map{|v| (v * (v+1))/2}
      sum = distances.sum
      cheapest = sum if cheapest == -1 || sum < cheapest
    end

    @answer = cheapest
  end

end