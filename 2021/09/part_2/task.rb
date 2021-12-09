require 'common/base_task'
require 'set'

class Task < BaseTask

  def run
    map = @input_array.map{|r| r.chars.map(&:to_i)}
    rows = map.length
    cols = map[0].length

    basin_sizes = []

    [*0..rows-1].each do |r|
      [*0..cols-1].each do |c|
        if is_low_point(map, r, c)
          basin_sizes << basin_size(map, r, c)
        end
      end
    end

    @answer = basin_sizes.sort.last(3).inject(:*)

  end

  def is_low_point(map, r, c)
    value = map[r][c]

    to_check = points_to_check(r, c)

    lowest = to_check.map do |check|
      r_check = check[0]
      c_check = check[1]

      if r_check >= map.length || r_check < 0
        true
      elsif c_check >= map[0].length || c_check < 0
        true
      else
        map[r_check][c_check] > value
      end          
    end

    lowest.all?
  end

  def points_to_check(r, c)
    [[r-1, c], [r+1, c], [r, c-1], [r, c+1]]
  end

  def basin_size(map, r, c, visited=Set.new)
    size = 1
    visited.add([r,c])

    points_to_check(r, c).each do |point|
      r_check = point[0]
      c_check = point[1]

      next if r_check >= map.length || r_check < 0
      next if c_check >= map[0].length || c_check < 0
      next if map[r_check][c_check] == 9
      next if visited.include?([r_check, c_check])

      size += basin_size(map, r_check, c_check, visited)
    end

    size
  end

end
