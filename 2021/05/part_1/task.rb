require 'common/base_task'

class Task < BaseTask

  def run
    grid = []
    inputs = @input_array.map {|r| r.split(" -> ").map { |a| a.split(',')}}
    inputs.each do |line|
      x1, y1, x2, y2 = line[0][0].to_i, line[0][1].to_i, line[1][0].to_i, line[1][1].to_i

      if x1 == x2
        min, max = [y1, y2].minmax
        [*min..max].each do |y|
          if grid[x1].nil?
            grid[x1] = []
          end
          if grid[x1][y].nil?
            grid[x1][y] = 0
          end
          grid[x1][y] += 1
        end
      end

      if y1 == y2
        min, max = [x1, x2].minmax
        [*min..max].each do |x|
          if grid[x].nil?
            grid[x] = []
          end
          if grid[x][y1].nil?
            grid[x][y1] = 0
          end
          grid[x][y1] += 1
        end
      end

    end

    @answer = 0

    grid.each { |r| next if r.nil? ; r.each {|c| !c.nil? && c > 1 ? @answer +=1 : false }}
  end

end