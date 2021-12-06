require 'common/base_task'

class Task < BaseTask

  def run
    fish_ages = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @input_array[0].split(',').map(&:to_i).each { |f| fish_ages[f] += 1  }

    256.times do |i|
      end_of_day = [0, 0, 0, 0, 0, 0, 0, 0, 0]

      end_of_day[8] = fish_ages[0]
      end_of_day[7] = fish_ages[8]
      end_of_day[6] = fish_ages[7]+ fish_ages[0]
      end_of_day[5] = fish_ages[6] 
      end_of_day[4] = fish_ages[5]
      end_of_day[3] = fish_ages[4]
      end_of_day[2] = fish_ages[3]
      end_of_day[1] = fish_ages[2]
      end_of_day[0] = fish_ages[1]
      
      fish_ages = end_of_day
    end

    @answer = fish_ages.sum

  end

end