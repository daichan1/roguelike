def create_player
  puts "プレイヤーの名前を入力してください"
  player_name = gets.strip
  player = Player.new(player_name)
  player
end

def menu_select
  puts "メニューを選択してください(1:ゲームスタート 9:ゲーム終了)"
  menu_number = gets.to_i
  menu_number
end
