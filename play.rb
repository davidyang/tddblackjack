require './black_jack'
GAME_COUNT = (ARGV[0] || 10).to_i #number of games to simulate

win_count = 0
push_count = 0
played_count = 0

print_stats = Proc.new do
  puts "\t Games played:\t #{played_count}"
  puts "\t Games won:\t #{win_count}"
  puts "\t Win rate:\t #{(win_count.to_f/played_count.to_f)*100}%"
end

game = Game.new

if (ARGV[1])
  strat = Kernel.const_get(ARGV[1]).new(game)
  game.player.strategy = strat
  puts "Using strategy: #{strat.class.name}"
end

GAME_COUNT.times do 
  played_count += 1
  puts "NEW GAME: #{played_count}"

  game.deal
  winner = game.play
  loser = nil
  if (winner.nil?) 
    push_count += 1
    puts "Push!" 
    next
  elsif (winner.kind_of? Player)
    win_count += 1
    loser = game.dealer
  else
    loser = game.player
  end
  puts "#{winner.name} Wins #{winner.total} to #{loser.total}" 
end

puts "====== Done! ======"
print_stats.call
