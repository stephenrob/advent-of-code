require 'common/test_helper'
require_relative 'task.rb'

class TaskTest < Minitest::Test

  def setup
    @input_file = "#{File.dirname(__FILE__)}/test_input.txt"
    @task = Task.new(input_file: @input_file)
  end

  def test_sets_answer_to_number_of_valid_passports
    @task.call
    assert_equal 4, @task.answer
  end

  def test_validate_length_returns_true_if_field_is_correct_length
    field = 2020
    length = 4
    assert @task.validate_length(field, length)
  end

  def test_validate_length_returns_false_if_field_is_not_correct_length
    field = 202
    length = 4
    refute @task.validate_length(field, length)
  end

  def test_valid_between_returns_true_if_field_is_between_specified_values
    field = 2020
    config = {
      lower_bound: 2000,
      upper_bound: 2040
    }
    assert @task.validate_between(field, config)
  end

  def test_valid_between_returns_false_if_field_is_not_between_specified_values
    field = 2020
    config = {
      lower_bound: 2000,
      upper_bound: 2010
    }
    refute @task.validate_between(field, config)
  end

  def test_valid_between_returns_true_if_field_is_at_specified_boundary_values
    field = 2020
    config = {
      lower_bound: 2020,
      upper_bound: 2040
    }
    assert @task.validate_between(field, config)

    field = 2040
    config = {
      lower_bound: 2020,
      upper_bound: 2040
    }
    assert @task.validate_between(field, config)
  end

  def test_validate_enum_returns_true_if_field_in_allowed_values
    field = "amb"
    allowed_values = %w(amb blu brn gry grn hzl oth)
    assert @task.validate_enum(field, allowed_values)
  end

  def test_validate_enum_returns_false_if_field_not_in_allowed_values
    field = "blk"
    allowed_values = %w(amb blu brn gry grn hzl oth)
    refute @task.validate_enum(field, allowed_values)
  end

  def test_validate_regex_returns_true_if_field_matches
    field = "#123abc"
    regex = /^#[0-9a-f]{6}$/
    assert @task.validate_regex(field, regex)
  end

  def test_validate_regex_returns_true_if_field_matches_chars
    field = "#fffabc"
    regex = /^#[0-9a-f]{6}$/
    assert @task.validate_regex(field, regex)
  end

  def test_validate_regex_returns_false_if_field_does_not_match
    field = "123abz"
    regex = /^#[0-9a-f]{6}$/
    refute @task.validate_regex(field, regex)
  end

  def test_validate_height_returns_true_if_height_passes_validation_for_unit
    config = {
      valid_units: ['cm', 'in'],
      cm: {
        between: {
          lower_bound: 150,
          upper_bound: 193
        }
      },
      in: {
        between: {
          lower_bound: 59,
          upper_bound: 76
        }
      }
    }

    height_cm = "170cm"
    height_in = "64in"

    assert @task.validate_height(height_cm, config)
    assert @task.validate_height(height_in, config)
  end

  def test_validate_height_returns_false_if_unit_not_a_valid_unit
    config = {
      valid_units: ['cm', 'in']
    }
    field = '1.7m'
    refute @task.validate_height(field, config)
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
      byr: "1980",
      iyr: "2012",
      eyr: "2030",
      hgt: "74in",
      hcl: "#623a2f",
      ecl: 'grn',
      pid: '087499704',
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
