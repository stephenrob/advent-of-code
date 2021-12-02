require 'common/base_task'

class Task < BaseTask

  def run
    horizontal, vertical, aim = 0, 0, 0

    @input_array.map {|c| c.split(" ")}.each do |command, count|
      case command
      when "forward"
        horizontal += count.to_i
        vertical += (count.to_i * aim)
      when "down"
        aim += count.to_i
      when "up"
        aim -= count.to_i
      end
    end

    @answer = horizontal*vertical
  end

end