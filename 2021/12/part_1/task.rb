require 'common/base_task'
require 'set'

class Task < BaseTask

  DEBUG = false

  def run
    paths_input = @input_array.map { |r| r.split('-')}

    map = parse_paths(paths_input)

    distinct_paths = Set.new

    puts map if DEBUG

    map["start"].each do |cave|
      path = ["start"]
      path << cave

      res = generate_paths(map, path.dup, cave)

      puts "RESULTS" if DEBUG

      puts res.to_s if DEBUG

      res.each { |r| distinct_paths << r }
    end

    puts "DISTINCT PATHS" if DEBUG
  
    distinct_paths.each { |path| puts path.to_s } if DEBUG

    @answer = distinct_paths.length

  end

  def parse_paths(input)

    map = {}

    input.each do |s, e|
      map[s] = [] if map[s].nil?
      map[e] = [] if map[e].nil?

      if s == "start"
        map[s] << e
      elsif s == "end"
        map[e] << s
      elsif e == "start"
        map[e] << s
      elsif e == "end"
        map[s] << e
      else
        map[s] << e
        map[e] << s
      end

    end

    map

  end

  def generate_paths(map, path, current_cave, visited=Set.new)
    paths = []

    puts "Path: #{path}" if DEBUG
    puts "Current Cave: #{current_cave}" if DEBUG
    puts "Visited: #{visited}" if DEBUG

    visited << current_cave

    map[current_cave].each do |next_cave|

      if next_cave.downcase == next_cave && visited.include?(next_cave)
        next
      end

      new_path = path.dup << next_cave
      puts "New Path: #{new_path}" if DEBUG
      if "end" == next_cave
        puts "END OF PATH" if DEBUG
        paths.push new_path
        next
      end
      new_paths = generate_paths(map, new_path, next_cave, visited.dup)
      puts "New Paths" if DEBUG
      new_paths.each { |np| puts np.to_s} if DEBUG

      new_paths.each {|np| paths.push np}
    end

    puts "Generated Paths" if DEBUG
    paths.each { |np| puts np.to_s } if DEBUG

    paths
  end

end