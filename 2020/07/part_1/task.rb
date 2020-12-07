require 'common/base_task'
require 'set'

class Task < BaseTask

  def run
    @answer = number_bags_can_contain 'shiny gold'
  end

  def number_bags_can_contain bag
    bags = parse_rules(@input_array)
    contained_items = [bag]
    containers = Set.new
    while contained_items.any?
      to_find = contained_items.shift
      bags[to_find].each do |container|
        containers.add container
        contained_items << container
      end
    end
    containers.size
  end

  # Returns a hash keyed on bag colour and value being an array of bags this is in
  def parse_rules(input)
    container_bags = Hash.new {|hash, key| hash[key] = Array.new}
    input.each do |rule|
      type, contents = parse_rule(rule)
      contents.each do |c|
        container_bags[c[0]] << type
      end
    end
    container_bags
  end

  def parse_rule(rule)
    split = rule.split(' contain ')
    bag_type = split[0].split(' bags')[0]
    if split[1] ==  'no other bags.'
      contents = []
    else
      contents = split[1].split(', ').map{|b| count = b.split(' bag')[0].split(' ')[0]; type = b.split(' bag')[0].split(' ')[1..].join(' '); [type, count.to_i]}
    end
    [bag_type, contents]
  end

end