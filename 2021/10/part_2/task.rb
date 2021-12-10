require 'common/base_task'

class Task < BaseTask

  def run

    

    incorrect_chars = []

    incomplete_lines = []

    @input_array.each do |line|
      incomplete_lines << line unless is_corrupt(line)
    end

    completed_by = incomplete_lines.map do |line|
      complete_line(line)
    end

    scores = completed_by.map { |completion| score_completion(completion)}

    @answer = scores.sort[(scores.length - 1)/2]

  end

  def score_completion(completion)
    score = 0

    points_lookup = [")", "]", "}", ">"]

    completion.each do |c|
      score *= 5
      score += (points_lookup.find_index(c) + 1)
    end

    score
  end

  def complete_line(line)
    open_to_close_mapping = {
      "(" => ")",
      "{" => "}",
      "[" => "]",
      "<" => ">"
    }

    close_to_open_mapping = {
      ")" => "(",
      "}" => "{",
      "]" => "[",
      ">" => "<"
    }

    line_stack = []

    line.chars.each do |c|
        
      if (open_to_close_mapping[c])
        line_stack << open_to_close_mapping[c]
      elsif (close_to_open_mapping[c])
        closing = line_stack.pop
      end

    end

    line_stack.reverse

  end

  def is_corrupt(line)

    open_to_close_mapping = {
      "(" => ")",
      "{" => "}",
      "[" => "]",
      "<" => ">"
    }

    close_to_open_mapping = {
      ")" => "(",
      "}" => "{",
      "]" => "[",
      ">" => "<"
    }

    line_stack = []

    line.chars.each do |c|
        
      if (open_to_close_mapping[c])
        line_stack << open_to_close_mapping[c]
      elsif (close_to_open_mapping[c])
        closing = line_stack.pop
        return true if closing != c
      end

    end

    return false

  end

end