require 'common/base_task'

class Task < BaseTask

  def run
    # Put task solution code here
    gamma_rate, epsilon_rate, bit_length = 0, 0, @input_array[0].chars.count
    
    gamma_rate = @input_array.map(&:chars).transpose.map { |bits| count = bits.map(&:to_i).select.count { |bit| bit == 0 } ; count > bits.size/2 ? 0 : 1 }.join.to_i(2)

    epsilon_rate = gamma_rate ^ (2**bit_length - 1)

    @answer = gamma_rate * epsilon_rate
  end

end