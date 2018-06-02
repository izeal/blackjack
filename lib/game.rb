class Game
  attr_reader :deck, :player, :dealer

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @deck = Deck.new.shuffle!
  end

  def over?
    return true if dealer.too_much_or_eq? || player.too_much_or_eq?
  end

  def result
    if (dealer.too_much? && player.too_much?) || dealer.card_sum == player.card_sum
      "Ничья"
    elsif (player.card_sum < dealer.card_sum && !dealer.too_much?) || (player.too_much? && !dealer.too_much?)
      player.cash -= 10
      "#{dealer.name} выиграл, у вас осталось #{player.cash}$"
    else
      player.cash += 10
      "Вы выиграли, у вас #{player.cash}$"
    end
  end

  def give_out_cards(count)
    dealer.take_from(self.deck, count) if dealer.card_sum < 17
    player.take_from(self.deck, count) if player.one_more
  end

  def status
    status_of(dealer) + status_of(player) << "\n###########################################\n\n"
  end

  def reset!
    @deck = Deck.new.shuffle!
    player.head_reset!
    dealer.head_reset!
  end

  private

  def status_of(model)
    result = []
    result << "\nКарты #{model.name}:\n" << model.hand << "Очки #{model.name}: #{model.card_sum}"
  end
end
