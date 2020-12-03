class BaseTask

  attr_reader :input_file, :input_array, :answer

  def initialize(input_file: 'input.txt')
    @input_file = input_file
    @input_array = nil
    @answer = nil
  end

  def call
    read_input_file_to_array
    run
  end

  def read_input_file_to_array
    @input_array = File.readlines(input_file).map {|l| l.chomp}
  end
  
  def run
    raise NotImplementedError
  end

end