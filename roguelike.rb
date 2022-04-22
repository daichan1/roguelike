require 'pry'
require './constant'
require './class/enemy'
require './class/card'
require './class/player'
require './module/main_menu'
require './module/route_select'
require './module/battle.rb'

include Battle

puts "ローグライクへようこそ！"

player = create_player

while true do
  menu_number = menu_select
  case menu_number
  when GAME_START
    game_continue = true
    while game_continue do
      route_decision = UN_ROUTED
      while route_decision === UN_ROUTED do
        route_decision = route_select(route_decision)
      end
      enemies = [Slime.new, Goblin.new]
      game_continue = Battle.start(player, enemies, game_continue)
    end
  when GAME_END
    puts "ゲームを終了します"
    exit
  else
    puts "1か9を入力してください"
  end
end
