require 'common/base_task'

class Task < BaseTask

  def run
    to_validate = @input_array.map { |line| parse_input_line(line) }
    valid_passwords = to_validate.keep_if { |password| password_valid?(password) }
    @answer = valid_passwords.length
  end

  def password_valid?(p)
    (p[:password][p[:first_pos]] == p[:char] && p[:password][p[:last_pos]] != p[:char]) || (p[:password][p[:first_pos]] != p[:char] && p[:password][p[:last_pos]] == p[:char])
  end

  def parse_input_line(line)
    components = line.split(' ')
    {
      first_pos: components[0].split('-')[0].to_i - 1,
      last_pos: components[0].split('-')[1].to_i - 1,
      char: components[1].split(':')[0],
      password: components[2]
    }
  end

end