require 'common/base_task'

class Task < BaseTask

  def run

    points_lookup = {
      ")" => 3,
      "]" => 57,
      "}" => 1197,
      ">" => 25137
    }

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

    incorrect_chars = []

    @input_array.each do |line|

      line_stack = []

      line.chars.each do |c|
        
        if (open_to_close_mapping[c])
          line_stack << open_to_close_mapping[c]
        elsif (close_to_open_mapping[c])
          closing = line_stack.pop
          incorrect_chars << c if closing != c
        end

      end
      
    end

    @answer = incorrect_chars.map {|c| points_lookup[c]}.sum

  end

end