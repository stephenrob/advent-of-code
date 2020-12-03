require 'common/test_helper'
require_relative 'task.rb'

class TaskTest < Minitest::Test

  def setup
    @task = Task.new(input_file: "#{File.dirname(__FILE__)}/test_input.txt")
  end

  def test_returns_number_of_trees_hit_for_variation
    rules = {
      row_offset: 1,
      column_offset: 3
    }
    @task.read_input_file_to_array
    map = @task.input_array
    assert_equal 7, @task.trees_hit(rules, map)
  end

end
