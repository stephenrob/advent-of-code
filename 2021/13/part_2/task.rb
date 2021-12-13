require 'common/base_task'

class Task < BaseTask

  DEBUG = false
  SHOW_ANSWER = true

  def run
    marks = @input_array.dup.keep_if { |v| v != "" && !v.start_with?("fold")}.map {|v| v.split(',').map(&:to_i)}
    folds = @input_array.dup.keep_if { |v| v.start_with?("fold")}.map {|v| [v.split("=")[0].chars.last, v.split("=")[1]]}

    paper = []

    puts marks.to_s if DEBUG

    marks.each do |x, y|
      paper[y] = [] if paper[y].nil?
      paper[y][x] = '#'
    end

    max_length = paper.map{|v| v.nil? ? [] : v}.max_by(&:length).length
    puts "MAX LENGTH: #{max_length}" if DEBUG

    complete = paper.map do |row|
      row = [] if row.nil?
      [*0..max_length-1].map do |i|
        row[i].nil? ? nil : row[i]
      end
    end

    output = complete.dup

    folds.each do |direction, position|
      output = fold(output, direction, position)
    end

    puts "===== ANSWER =====" if SHOW_ANSWER
    output.map{|r| r.map{|c| c.nil? ? '.' : '#'}}.each {|r| puts r.join.to_s} if SHOW_ANSWER
    
    @answer = output.to_s

  end

  def fold(input, direction, position)
    complete = input
    complete.each { |r| puts r.to_s } if DEBUG
    folded = []

    position = position.to_i

    case direction
    when "y"
      complete.each_with_index do |row, row_index|
        folded[row_index] = [] if row_index < position
        next if row_index == position

        row.each_with_index do |col, col_index|
          if row_index > position
            new_row_index = position - (row_index - position)
            folded[new_row_index][col_index] = ((col == '#') || (folded[new_row_index][col_index] == '#')) ? '#' : nil
          else
            folded[row_index][col_index] = col == '#' ? '#' : nil
          end
        end

      end
    when "x"
      complete.each_with_index do |row, row_index|
        folded[row_index] = []
        row.each_with_index do |col, col_index|
          next if col_index == position
          if col_index > position
            new_col_index = position - (col_index - position)
            folded[row_index][new_col_index] = ((col == '#') || folded[row_index][new_col_index] == '#') ? '#' : nil
          else
            folded[row_index][col_index] = col == '#' ? '#': nil
          end
        end
      end
    end

    folded

  end

end