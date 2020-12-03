require 'common/test_helper'
require_relative 'task.rb'

class TaskTest < Minitest::Test

  def setup
    @task = Task.new(input_file: "#{File.dirname(__FILE__)}/test_input.txt")
  end

  def test_returns_true_if_password_matches_rules
    row = "1-3 a: abcde"
    password = @task.parse_input_line(row)
    puts password
    assert @task.password_valid?(password)
  end

  def test_returns_false_if_password_does_not_match_rules
    row = "2-9 c: ccccccccc"
    password = @task.parse_input_line(row)
    refute @task.password_valid?(password)
  end

  def test_parse_input_line_returns_password_details
    # Turns input character positions to zero based array values
    line = "1-3 a: abcde"

    expected_result = {
      first_pos: 0,
      last_pos: 2,
      char: 'a',
      password: 'abcde'
    }

    assert_equal expected_result, @task.parse_input_line(line)
  end

end
