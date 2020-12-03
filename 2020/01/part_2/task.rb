require 'common/base_task'

class Task < BaseTask

  def run
    sum = 2020
    permutation_count = 3

    expenses = @input_array.map {|l| l.to_i}

    @answer = expenses.permutation(permutation_count).find { |p| p.sum == sum}.inject(:*)
  end

end