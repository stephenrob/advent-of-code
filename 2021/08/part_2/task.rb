require 'common/base_task'

class Task < BaseTask

  def run
    number_segments = ["abcefg", "cf", "acdeg", "acdfg", "bcdf", "abdfg", "abdefg", "acf", "abcdefg", "abcdfg"]
    lines = @input_array.map{ |r| r.split(" | ") }

    outputs = lines.map do |l|

      line_segments = []
      signals, outputs = l[0].split(" "), l[1].split(" ")
      values = signals.concat(outputs).flatten

      values.each do |v|
        line_segments[1] = v if v.length == 2
        line_segments[7] = v if v.length == 3
        line_segments[4] = v if v.length == 4
        line_segments[8] = v if v.length == 7
      end

      values.each do |v|
        line_segments[3] = v if v.length == 5 && (line_segments[1].chars - v.chars).empty?
      end

      values.each do |v|
        line_segments[6] = v if v.length == 6 && !(line_segments[1].chars - v.chars).empty?
      end

      values.each do |v|
        top_left = (line_segments[1].chars - line_segments[6].chars)
        if v.length == 5
          next if (line_segments[1].chars - v.chars).empty?
          line_segments[2] = v if (top_left - v.chars).empty?
          line_segments[5] = v if !(top_left - v.chars).empty?
        end
      end

      values.each do |v|
        if v.length == 6
          next if !(line_segments[1].chars - v.chars).empty?
          bottom_left = (line_segments[6].chars - line_segments[5].chars)[0]
          line_segments[9] = v if !v.chars.include?(bottom_left)
          line_segments[0] = v if v.chars.include?(bottom_left)
        end
      end

      outputs.map { |o| line_segments.map {|v| v.chars.sort.join}.find_index(o.chars.sort.join)}.join

    end

    @answer = outputs.map(&:to_i).sum

  end

end