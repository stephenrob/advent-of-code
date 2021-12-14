require 'common/base_task'

class Task < BaseTask

  def run
    template, insertion_rules = @input_array[0], @input_array[2..]
    rules = {}
    insertion_rules.each { |r| k, v = r.split(' -> ') ; rules[k] = v}
    string = template.dup

    res = run_rules_on_template(rules, string, 40)

    @answer = res.values.max - res.values.min

  end

  # Count the number of times each pair appears and then the chars
  def run_rules_on_template(rules, template, times=0)
    pairs = template.chars.each_cons(2).each_with_object(Hash.new(0)) { |pair, counts| counts[pair] += 1}

    times.times do
      pairs = pairs.each_with_object(Hash.new(0)) do |(k, v), updated|
        insert_char = rules[k.join]
        updated[[k[0], insert_char]] += v
        updated[[insert_char, k[1]]] += v
      end
    end

    char_counts = pairs.each_with_object(Hash.new(0)) { |(k, v), totals| totals[k[0]] += v}
    char_counts[template.chars.last] += 1

    char_counts
  end

end