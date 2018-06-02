# это для того чтоб на винде кирилицу показывало
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/load'

player = Player.new
dealer = Player.new('Angry Dealer')
game = Game.new(player, dealer)

puts "Добро пожаловать в казино #{player.name}!\nЗа этим стололм играют в БлэкДжек.\nСколько у Вас денег сегодня?"

cash = STDIN.gets.strip
until cash == cash.to_i.to_s
  puts "Введите целое число"
  cash = STDIN.gets.strip
end

player.cash = cash.to_i

puts "\n#{player.name} у вас #{player.cash}$"
puts "\nCтавка 10$" # todo bet

while player.cash >= 10
  game.reset!

  puts "\nПротив Вас играет #{dealer.name}"

  game.give_out_cards(2)
  puts game.status
  sleep(1)

  until game.over? || !player.one_more
    puts "Взять еще карту? 1 - Да, 0 - Нет"

    input = STDIN.gets.to_i
    player.one_more?(input)

    game.give_out_cards(1)
    puts game.status
    sleep(1)
  end

  puts game.result

  puts "\n\nХотите сыграть еще? 1 - Да, 0 - Нет"
  input = STDIN.gets.strip
  break unless input == '1'
end

puts "\n###########################################\n\n"
puts "Досвидания #{player.name}, Вы уходите с #{player.cash}$"


