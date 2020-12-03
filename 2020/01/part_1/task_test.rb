require 'common/test_helper'
require_relative 'task.rb'

class TaskTest < Minitest::Test

  def setup
    @task = Task.new(input_file: "#{File.dirname(__FILE__)}/test_input.txt")
  end
  
  def test_multiplys_the_two_numbers_that_add_to_2020
    @task.call
    assert_equal 514579, @task.answer
  end

end
