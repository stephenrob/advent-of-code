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

  def validate_length field, length
    field.to_s.length == length
  end

  def validate_between field, config
    lower_bound = config[:lower_bound]
    upper_bound = config[:upper_bound]
    field.to_i >= lower_bound && field.to_i <= upper_bound
  end

  def validate_enum field, values
    values.include?(field)
  end

  def validate_regex field, regex
    field.match(regex)
  end

  def validate_height field, config
    valid_units = config[:valid_units]
    unit = field.chars.last(2).join
    return false unless valid_units.include?(unit)
    height = field.split(unit).first
    unit_rules = config[unit.to_sym]
    unit_rules.each do |rule, config|
      return false unless send "validate_#{rule}", height, config
    end
  end

  def validation_rules
    {
      byr: {
        required: true,
        length: 4,
        between: {
          lower_bound: 1920,
          upper_bound: 2002
        }
      },
      iyr: {
        required: true,
        length: 4,
        between: {
          lower_bound: 2010,
          upper_bound: 2020
        }
      },
      eyr: {
        required: true,
        length: 4,
        between: {
          lower_bound: 2020,
          upper_bound: 2030
        }
      },
      hgt: {
        required:  true,
        height: {
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
      },
      hcl: {
        required: true,
        regex: /^#[0-9a-f]{6}$/
      },
      ecl: {
        required: true,
        enum: %w(amb blu brn gry grn hzl oth)
      },
      pid: {
        required: true,
        length: 9
      },
      cid: {
        required: false
      }
    }
  end

end