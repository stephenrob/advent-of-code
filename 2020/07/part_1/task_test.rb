require 'common/test_helper'
require_relative 'task.rb'

class TaskTest < Minitest::Test

  def setup
    @task = Task.new(input_file: "#{File.dirname(__FILE__)}/test_input.txt")
  end

  def test_returns_correct_number_of_bags
    @task.call
    assert_equal 4, @task.answer
  end

  def test_parses_rule_to_array
    rule = 'light red bags contain 1 bright white bag, 2 muted yellow bags.'
    expected = ['light red', [['bright white', 1], ['muted yellow', 2]]]
    assert_equal expected,  @task.parse_rule(rule)
  end

  def test_returns_hash_of_container_bags
    rules = ['light red bags contain 1 bright white bag, 2 muted yellow bags.']
    expected = {"bright white"=>["light red"], "muted yellow"=>["light red"]}
    assert_equal expected, @task.parse_rules(rules)
  end

end
