require 'common/base_task'

class Task < BaseTask

  def run
    @answer = variations.map{|v| trees_hit(v, @input_array)}.inject(:*)
  end

  def trees_hit(rules, map)
    trees_hit = 0
    current_row = rules[:row_offset]
    current_col = 1
    row_offset = rules[:row_offset]
    column_offset = rules[:column_offset]

    map.each_with_index do |row, index|

      next if should_skip?(index, current_row)

      current_row += row_offset
      current_col += column_offset
      row_length = row.length

      if current_col > row_length
        current_col = current_col - row_length
      end

      if tree_at_row_position?(row, current_col)
        trees_hit += 1
      end

    end

    trees_hit
  end

  def variations
    variations = [
      {
        row_offset: 1,
        column_offset: 1
      },
      {
        row_offset: 1,
        column_offset: 3
      },
      {
        row_offset: 1,
        column_offset: 5
      },
      {
        row_offset: 1,
        column_offset: 7
      },
      {
        row_offset: 2,
        column_offset: 1
      }
    ]
  end

  def should_skip?(index, current_row)
    return true if index == 0
    true if index != current_row
  end

  def get_row_value_at_position(row, position)
    row[position - 1]
  end
  
  def tree_at_row_position?(row, position)
    get_row_value_at_position(row, position) == '#'
  end

end