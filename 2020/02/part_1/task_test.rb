require 'common/test_helper'
require_relative 'task.rb'

class TaskTest < Minitest::Test

  def setup
    @task = Task.new(input_file: "#{File.dirname(__FILE__)}/test_input.txt")
  end

  def test_sets_answer_to_number_of_passwords_matching_rules
    @task.call
    assert_equal 2, @task.answer
  end

  def test_returns_true_if_password_matches_rules
    row = "1-3 a: abcde"
    password = @task.parse_input_line(row)
    assert @task.password_valid?(password)
  end

  def test_returns_false_if_password_does_not_match_rules
    row = "1-3 b: cdefg"
    password = @task.parse_input_line(row)
    refute @task.password_valid?(password)
  end

  def test_parse_input_line_returns_details
    line = "1-3 a: abcde"

    expected_result = {
      min: 1,
      max: 3,
      char: 'a',
      password: 'abcde'
    }

    assert_equal expected_result, @task.parse_input_line(line)
  end

end
