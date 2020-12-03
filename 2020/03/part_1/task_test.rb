require 'common/test_helper'
require_relative 'task.rb'

class TaskTest < Minitest::Test

  def setup
    @task = Task.new(input_file: "#{File.dirname(__FILE__)}/test_input.txt")
  end

  def test_returns_number_of_trees_hit_as_answer
    @task.call
    assert_equal 7, @task.answer
  end

end
