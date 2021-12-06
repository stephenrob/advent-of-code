require 'common/base_task'

class Task < BaseTask

  def run
    initial = @input_array[0].split(',').map(&:to_i)
    80.times do |i|
      extras = []
      end_of_day = initial.map do |v| 
        if v == 0
          extras << 8
          v = 6
        else
          v - 1
        end
      end
      initial = end_of_day.concat(extras)
    end
    @answer = initial.length
  end

end