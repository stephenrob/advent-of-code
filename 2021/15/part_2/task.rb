require 'common/base_task'
require 'rb_heap/heap'

class Task < BaseTask

  DEBUG = false
  ADJACENT = [[1,0], [-1, 0], [0, 1], [0, -1]].freeze

  def run
    grid = @input_array.map {|r| r.chars.map(&:to_i)}

    pos_start = [0, 0]
    pos_end = [grid.length-1, grid[0].length-1]
    rows = grid.length
    cols = grid[0].length

    grid.each {|r| puts r.to_s } if DEBUG
    if DEBUG
      puts "Start Position: #{pos_start}"
      puts "End Position: #{pos_end}"
      puts "Rows: #{rows}"
      puts "Cols: #{cols}"
    end

    full_grid = (rows * 5).times.map do |r|
      (cols * 5).times.map do |c|
        depth = (r / rows) + (c / cols)
        risk = grid[r%rows][c%cols]
        ((risk + depth -1) % 9) + 1
      end
    end

    pos_start = [0, 0]
    pos_end = [full_grid.length-1, full_grid[0].length-1]
    rows = full_grid.length
    cols = full_grid[0].length

    queue = []

    # [x, y, risk]
    queue << [0,0,0]

    risks = { [0,0] => 0}

    loop do
      break if queue.empty?
      x, y, risk = queue.shift
      break if [x, y] == pos_end
      
      adjacent_points = ADJACENT.filter_map do |dx, dy|
        next if x + dx < 0 || x + dx >= rows
        next if y + dy < 0 || y + dy >= cols

        [x + dx, y + dy]
      end

      adjacent_points.each do |new_x, new_y|
        new_risk = risk + full_grid[new_x][new_y]
        next if risks.key?([new_x, new_y]) && risks[[new_x, new_y]] <= new_risk
        
        risks[[new_x, new_y]] = new_risk
        queue << [new_x, new_y, new_risk]
      end

    end

    @answer = risks[pos_end]

  end

end