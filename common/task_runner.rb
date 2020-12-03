class TaskRunner

  attr_reader :task_name, :task_class

  def initialize(task_name, task_class)
    @task_name = task_name
    @task_class = task_class
  end

  def run

    require task_file

    puts "Running task: #{task_name}"

    task = Kernel.const_get(task_class).new(input_file: task_input_file)
    task.call

    puts "Answer: #{task.answer}"

  end

  def task_file
    "#{task_name}/task.rb"
  end

  def task_input_file
    "#{task_name}/input.txt"
  end

end

# task_name = ARGV[0]
# task_class = ARGV[1]

# task_class = 'Task' if task_class.nil?

# runner = TaskRunner.new(task_name, task_class)
# runner.run