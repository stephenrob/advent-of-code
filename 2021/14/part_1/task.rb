require 'common/base_task'

class Task < BaseTask

  def run
    template, insertion_rules = @input_array[0], @input_array[2..]
    rules = {}
    insertion_rules.each { |r| k, v = r.split(' -> ') ; rules[k] = v}
    string = template.dup

    10.times do
      string = run_rules_on_template(rules, string)
    end

    chars = string.chars.uniq

    res = chars.map {|c| string.count(c)}

    puts res.to_s

    @answer = res.max - res.min

  end

  def run_rules_on_template(rules, template)
    res = template.chars.each_cons(2)
    (res.map { |r| [r[0], rules[r.join]]} << template.chars[-1]).flatten.join
  end

end