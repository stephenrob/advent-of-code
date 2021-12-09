require 'common/base_task'

class Task < BaseTask

  def run
    map = @input_array.map{|r| r.chars.map(&:to_i)}
    rows = map.length
    cols = map[0].length

    low_points = []

    [*0..rows-1].each do |r|
      [*0..cols-1].each do |c|
        value = map[r][c]

        to_check = [[r-1, c], [r+1, c], [r, c-1], [r, c+1]]

        lowest = to_check.map do |check|
          r_check = check[0]
          c_check = check[1]

          if r_check >= rows || r_check < 0
            true
          elsif c_check >= cols || c_check < 0
            true
          else
            map[r_check][c_check] > value
          end          
        end

        low_points << value if lowest.all?

      end
    end

    @answer = low_points.map{|v| v+=1 }.sum

  end

end