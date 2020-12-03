require 'common/base_task'

class Task < BaseTask

  def run
    to_validate = @input_array.map { |line| parse_input_line(line) }
    valid_passwords = to_validate.keep_if { |password| password_valid?(password) }
    @answer = valid_passwords.length
  end

  def password_valid?(p)
    p[:min] <= p[:password].count(p[:char]) && p[:password].count(p[:char]) <= p[:max]
  end

  def parse_input_line(line)
    components = line.split(' ')
    {
      min: components[0].split('-')[0].to_i,
      max: components[0].split('-')[1].to_i,
      char: components[1].split(':')[0],
      password: components[2]
    }
  end
end