require 'common/base_task'

class Task < BaseTask

  def run
    horizontal, vertical = 0, 0

    @input_array.map {|c| c.split(" ")}.each do |command, count|
      case command
      when "forward"
        horizontal += count.to_i
      when "down"
        vertical += count.to_i
      when "up"
        vertical -= count.to_i
      end
    end

    @answer = horizontal*vertical
  end

end