require 'common/base_task'

class Task < BaseTask

  DEBUG = false

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

    complete.each { |r| puts r.to_s } if DEBUG

    direction, position = folds[0]

    folded = []

    case direction
    when "y"
      keep = complete[0..position.to_i-1]
      to_flip = complete[position.to_i+1..]

      reversed = to_flip.reverse

      puts "===== TO FLIP =====" if DEBUG
      to_flip.each {|r| puts r.to_s} if DEBUG
      puts "===== REVERSED =====" if DEBUG
      reversed.each {|r| puts r.to_s} if DEBUG

      merged = []

      keep.each_with_index do |r, r_index|
        merged[r_index] = []
        r.each_with_index do |c, c_index|
          if c == '#' || reversed[r_index][c_index] == '#'
            merged[r_index] << '#'
          else
            merged[r_index] << nil
          end
        end
      end

      puts "===== MERGED ====="
      merged.each {|r| puts r.to_s} if DEBUG

      folded = merged.dup

    when "x"
      keep = complete.map {|r| r[0..position.to_i-1]}
      to_flip = complete.map {|r| r[position.to_i+1..]}

      reversed = to_flip.map(&:reverse)

      puts "===== TO FLIP =====" if DEBUG
      to_flip.each {|r| puts r.to_s} if DEBUG
      puts "===== REVERSED =====" if DEBUG
      reversed.each {|r| puts r.to_s} if DEBUG

      merged = []

      keep.each_with_index do |r, r_index|
        merged[r_index] = []
        r.each_with_index do |c, c_index|
          if c == '#' || reversed[r_index][c_index] == '#'
            merged[r_index] << '#'
          else
            merged[r_index] << nil
          end
        end
      end

      puts "===== MERGED =====" if DEBUG
      merged.each {|r| puts r.to_s} if DEBUG

      folded = merged.dup
    end

    @answer = folded.map{|r| r.count('#')}.sum

  end

end