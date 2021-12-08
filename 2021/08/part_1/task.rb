require 'common/base_task'

class Task < BaseTask

  def run
    number_segments = ["abcefg", "cf", "acdeg", "acdfg", "bcdf", "abdfg", "abdefg", "acf", "abcdefg", "abcdfg"]
    lines = @input_array.map{ |r| r.split(" | ") }
    signals, outputs = lines.map { |l| l[0]}, lines.map { |l| l[1].split(" ").map{|o| o.chars.sort.join } }

    check = [1,4,7,8]
    to_match = check.map { |i| number_segments[i].length}
    @answer = 0

    outputs.flatten.each do |o|
      @answer += 1 if to_match.include?(o.length)
    end

  end

end