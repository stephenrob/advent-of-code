require 'common/test_helper'
require_relative 'task.rb'

class TaskTest < Minitest::Test

  def setup
    @input_file = "#{File.dirname(__FILE__)}/test_input.txt"
    @task = Task.new(input_file: @input_file)
  end

  def test_sets_answer_to_number_of_valid_passports
    @task.call
    assert_equal 2, @task.answer
  end

  def test_validate_required_returns_true_if_field_is_not_required
    field = ""
    required = false
    assert @task.validate_required(field, required)
  end

  def test_validate_required_returns_true_if_required_field_is_present
    field = "helloworld"
    required = true
    assert @task.validate_required(field, required)
  end

  def test_validate_required_returns_false_if_requires_field_is_empty
    field = ""
    required = true
    refute @task.validate_required(field, required)
  end
  
  def test_passport_valid_returns_true_if_passport_valid
    passport = {
      byr: "1937",
      iyr: "2017",
      eyr: "2020",
      hgt: "183cm",
      hcl: "#fffffd",
      ecl: 'gry',
      pid: '860033327',
      cid: '147'
    }
    assert @task.passport_valid? passport
  end
  
  def test_passport_valid_returns_false_if_any_rule_fails
    passport = {
      byr: "1929",
      iyr: "2013",
      eyr: "2023",
      hcl: "#cfa07d",
      ecl: 'amb',
      pid: '028048884',
      cid: '350'
    }
    refute @task.passport_valid? passport
  end

  def test_passport_valid_returns_true_if_passport_valid_without_cid
    passport = {
      byr: "1931",
      iyr: "2013",
      eyr: "2024",
      hgt: "179cm",
      hcl: "#ae17e1",
      ecl: 'brn',
      pid: '760753108',
    }
    assert @task.passport_valid? passport
  end

  def test_parse_passport_turns_input_string_to_passport
    passport = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm"

    expected_passport = {
      byr: "1937",
      iyr: "2017",
      eyr: "2020",
      hgt: "183cm",
      hcl: "#fffffd",
      ecl: 'gry',
      pid: '860033327',
      cid: '147'
    }

    assert_equal expected_passport, @task.parse_passport(passport)

  end

  def test_parse_passport_turns_input_string_to_passport_2
    passport = "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929"

    expected_passport = {
      byr: "1929",
      iyr: "2013",
      eyr: "2023",
      hcl: "#cfa07d",
      ecl: 'amb',
      pid: '028048884',
      cid: '350'
    }

    assert_equal expected_passport, @task.parse_passport(passport)

  end

end
