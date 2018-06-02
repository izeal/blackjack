class Hand
  def sum
    cards.map(&:cost).inject(:+) || 0
  end
end
