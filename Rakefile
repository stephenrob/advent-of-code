$LOAD_PATH << '.'

require 'fileutils'
require "rake/testtask"

require 'common/task_runner'

desc "Advent of Code Tasks"

namespace :aoc do
  desc "Create new task"
  task :create do

    task_name = ARGV[1]
    if ARGV[2].nil?
      task_parts = 2
    else
      task_parts = ARGV[2].to_1
    end

    if task_name.nil?
      puts "Requires task name to create"
      exit
    end

    puts "Creating task template"

    template_file_dir = "template"

    task_parts.times do |i|
      task_dir = "#{task_name}/part_#{i + 1}"
      FileUtils.mkdir_p task_dir
      Dir[template_file_dir + "/**"].each do |template_file|
        dest_file = template_file.gsub(template_file_dir, task_dir)
        FileUtils.cp(template_file, dest_file)
      end
    end

    exit

  end

  desc "Run task"
  task :run do
    task_name = ARGV[1]
    task_class = ARGV[2]

    task_class = 'Task' if task_class.nil?
    runner = TaskRunner.new(task_name, task_class)
    runner.run
    exit
  end

  Rake::TestTask.new(:test) do |t|
    task_dir = ARGV[1]
    t.libs << '.'
    t.test_files = FileList["#{task_dir}/*_test.rb"]
  end
end