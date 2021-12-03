require 'common/base_task'

class Task < BaseTask

  def run
    # Put task solution code here
    oxygen_rate, co2_rate, bit_length = 0, 0, @input_array[0].chars.count
    
    oxygen = @input_array.map(&:chars)
    co2 = @input_array.map(&:chars)

    bit_length.times do |i|
      count = oxygen.count { |o| o[i] == "0"}
      max_bit = count > oxygen.count/2 ? "0" : "1"
      oxygen.select!{|o| o[i] == max_bit}
      break if oxygen.count == 1 
    end

    bit_length.times do |i|
      count = co2.count { |o| o[i] == "0"}
      min_bit = count <= co2.count/2 ? "0" : "1"
      co2.select!{|o| o[i] == min_bit}
      break if co2.count == 1
    end

    oxygen_rate, co2_rate = oxygen.join.to_i(2), co2.join.to_i(2)
    
    @answer = oxygen_rate * co2_rate
  end

end