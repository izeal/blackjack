class Player
  attr_reader :name, :hand
  attr_accessor :cash, :one_more

  def initialize(name = nil, cash = 0)
    @name = set_name(name)
    @cash = cash
    @hand = Hand.new
    @one_more = true
  end

  def card_sum
    self.hand.sum
  end

  def take_from(deck, count)
    self.hand.draw(deck, count)
  end

  def too_much?
    self.card_sum > 21
  end

  def too_much_or_eq?
    self.card_sum >= 21
  end

  def one_more?(input)
    @one_more =
      input == 1 ? true : false
  end

  def head_reset!
    @hand = Hand.new
  end

  private

  def set_name(name)
    return name unless name.nil?
    ARGV[0] ? ARGV[0] : 'Anonymous'
  end
end
