require 'common/base_task'

class Task < BaseTask

  def run
    @answer = total_bags_within('shiny gold')
  end

  def total_bags_within bag
    child_bags = parse_rules(@input_array)
    total_bags = 0

    bags_to_count = [[bag, 1]] # array of bags to count, each element is [type, count]

    while bags_to_count.any?
      parent_bag, parent_count = bags_to_count.shift
      next unless child_bags[parent_bag]
      child_bags[parent_bag].each do |type, count|
        total_bags += count * parent_count
        bags_to_count << [type, count*parent_count]
      end
    end

    total_bags

  end

  def parse_rules(input)

    bags = {}

    input.each do |i|
      type, contents = parse_rule(i)
      bags[type] = contents
    end

    bags

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