require 'common/base_task'

class Task < BaseTask

  def run
    draw = @input_array[0].split(",")
    cards = @input_array[2...].reject{|r| r == ""}.each_slice(5).to_a.map {|c| c.map{|r| r.split(" ")}}

    winning_card = []
    winning_draw = 0

    draw.each do |d|
      cards = cards.map do |c|
        c == true ? c : c.map { |r| r.map { |v| v == d ? true : v}}
      end

      cards.each_with_index do |c, index|
        next if c == true
        if has_won(c)
          cards[index] = true
          winning_card = c
          winning_draw = d.to_i
        end
      end
    end

    card_sum = winning_card.map { |r| r.reject{|v| v == true}.map(&:to_i).sum}.sum
    @answer = card_sum * winning_draw

  end

  def has_won(card)
    card.each do |r|
      return true if r.all?{|v| v==true}
    end
    card.length.times do |i|
      col = card.map { |r| r[i]}
      return true if col.all?{|v| v==true}
    end
    return false
  end

end