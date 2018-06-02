class Card
  def cost
    cost = self.to_i
    cost = 10 if cost.between?(10,13)
    cost = 11 if cost == 14
    cost
  end
end
