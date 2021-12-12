require 'common/test_helper'
require_relative 'task.rb'

class TaskTest < Minitest::Test

  def setup
    @task_1 = Task.new(input_file: "#{File.dirname(__FILE__)}/test_input.txt")
    @task_2 = Task.new(input_file: "#{File.dirname(__FILE__)}/test_input_2.txt")
    @task_3 = Task.new(input_file: "#{File.dirname(__FILE__)}/test_input_3.txt")
  end

  def test_returns_correct_answer_for_task_1
    @task_1.call
    assert_equal 10, @task_1.answer
  end

  def test_returns_correct_answer_for_task_2
    @task_2.call
    assert_equal 19, @task_2.answer
  end

  def test_returns_correct_answer_for_task_3
    @task_3.call
    assert_equal 226, @task_3.answer
  end

end
