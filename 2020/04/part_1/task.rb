require 'common/base_task'

class Task < BaseTask

  def run
    passports_to_validate = parse_input_array.map {|input| parse_passport(input)}
    valid_passports = passports_to_validate.keep_if {|passport| passport_valid?(passport)}
    @answer = valid_passports.length
  end

  def parse_input_array
    @input_array.map{|l| l.chomp}.slice_after("").to_a.map { |l| l.join(" ").strip }
  end

  def parse_passport(input)
    passport = {}
    input.split(" ").each do |value|
      component = value.split(':')
      passport[component[0].to_sym] = component[1]
    end
    passport
  end

  def passport_valid? passport
    validation_rules.each do |field, rules|
      rules.each do |rule, config|
        return false unless send "validate_#{rule}", passport[field], config
      end
    end
    return true
  end

  def validate_required field, required=false
    return true unless required
    !(field.nil? || field.empty?)
  end

  def validation_rules
    {
      byr: {
        required: true
      },
      iyr: {
        required: true
      },
      eyr: {
        required: true
      },
      hgt: {
        required:  true
      },
      hcl: {
        required: true
      },
      ecl: {
        required: true
      },
      pid: {
        required: true
      },
      cid: {
        required: false
      }
    }
  end

end