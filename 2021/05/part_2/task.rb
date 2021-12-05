require 'common/base_task'

class Task < BaseTask

  def run
    grid = []
    inputs = @input_array.map {|r| r.split(" -> ").map { |a| a.split(',')}}
    inputs.each do |line|
      x1, y1, x2, y2 = line[0][0].to_i, line[0][1].to_i, line[1][0].to_i, line[1][1].to_i

      xmin, xmax = [x1, x2].minmax
      ymin, ymax = [y1, y2].minmax

      if x1 == x2
        [*ymin..ymax].each do |y|
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
        [*xmin..xmax].each do |x|
          if grid[x].nil?
            grid[x] = []
          end
          if grid[x][y1].nil?
            grid[x][y1] = 0
          end
          grid[x][y1] += 1
        end
      end

      if (xmax - xmin) == (ymax - ymin)
        length = ymax-ymin

        points = [[x2, y2]]

        length.times do |t|
          x = x1 < x2 ? xmin + t : xmax - t
          y = y1 < y2 ? ymin + t : ymax - t
          points << [x, y]
        end

        points.each do |point|
          x, y = point[0], point[1]
          if grid[x].nil?
            grid[x] = []
          end
          if grid[x][y].nil?
            grid[x][y] = 0
          end
          grid[x][y] += 1
        end

      end

    end

    @answer = 0
    grid.each { |r| next if r.nil? ; r.each {|c| !c.nil? && c > 1 ? @answer +=1 : false }}
  end

end