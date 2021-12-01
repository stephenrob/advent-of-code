require 'common/base_task'

class Task < BaseTask

  def run
    @answer = @input_array.map(&:to_i).each_cons(3).map(&:sum).each_cons(2).count { |a, b| b > a}
  end

end