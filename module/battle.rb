module Battle
  def start(player, enemies, game_continue)
    display_enemies_name(enemies)
    combat_continuity = true
    player.deck_shuffle
    while combat_continuity do
      player_turn(player, enemies)

      if is_annihilate_enemies(enemies)
        display_victory_result(enemies)
        next_battle_preparation(player)
        return game_continue
      end

      enemy_turn(player, enemies)

      if is_zero_hp(player)
        display_defeat_result(player)
        player.status_initialize
        game_continue = false
        combat_continuity = false
      end
      player.defense = 0
    end
    game_continue
  end

  def player_turn(player, enemies)
    puts "#{player.name}のターン"
    turn_continue = true
    card_draw(player)
    while turn_continue do
      display_player_status(player)
      display_enemy_status(enemies)

      card_number = card_select(player)
      card = player.nameplate[card_number - 1]
      is_card_useful = card.action(player)
      unless is_card_useful
        puts "エネルギーが足りません"
        turn_continue = turn_select(turn_continue)
        turn_continue ? next : break
      end
      puts card.name

      player.cemetery.push(card)
      player.nameplate.delete_at(card_number - 1)

      enemy_number = select_attack_enemy_number(enemies)
      enemy = enemies[enemy_number - 1]
      damage = calc_damage(enemy, player.attack)
      puts "#{damage}のダメージをあたえた"
      calc_remaining_hp(enemy, damage)
      player.attack -= card.attack

      return if is_annihilate_enemies(enemies)

      if is_zero_hp(enemy)
        enemies.delete_at(enemy_number - 1)
        display_defeated_enemy_message(enemy)
      end

      turn_continue = turn_select(turn_continue)
    end
    turn_end(player)
  end

  def enemy_turn(player, enemies)
    enemies.each do |enemy|
      display_enemy_attack(enemy)
      damage = calc_damage(player, enemy.attack)
      puts "#{damage}のダメージをうけた"
      calc_remaining_hp(player, damage)
    end
  end

  def card_select(player)
    card_number = 0
    card_decision = UN_CARD_SELECT
    while card_decision === UN_CARD_SELECT do
      display_nameplate(player)
      card_number = gets.to_i
      nameplate_count = (1..player.nameplate.length).to_a
      if nameplate_count.include?(card_number)
        card_decision = CARD_SELECTED
      else
        puts "1~#{player.nameplate.length}の間から入力してください"
      end
    end
    card_number
  end

  def turn_select(turn_continue)
    turn_decision = true
    while turn_decision do
      puts "ターンを終了しますか？(1: 続ける 9:終了する)"
      turn_number = gets.to_i
      if turn_number === 9
        turn_decision = false
        turn_continue = false
      elsif turn_number === 1
        turn_decision = false
      else
        puts "1,9のどちらかを入力してください"
      end
    end
    turn_continue
  end

  def select_attack_enemy_number(enemies)
    enemy_number = DEFAULT_SELECT_ENEMY_NUMBER
    enemy_decision = true
    enemy_names = ""
    enemies.each.with_index(1) do |enemy, index|
      enemy_names += "#{index}: #{enemy.name}"
    end
    while enemy_decision do
      puts "攻撃する敵を選択してださい"
      puts enemy_names
      enemy_number = gets.to_i
      enemies_count = (1..enemies.length).to_a
      if enemies_count.include?(enemy_number)
        enemy_decision = false
      else
        puts "1~#{enemies.length}の間から入力してください"
      end
    end
    enemy_number
  end

  def card_draw(player)
    player.deck_preparation if player.deck.length < DEFAULT_DECK_LENGTH
    nameplate_upper_limit = DEFAULT_NAMEPLATE_LENGTH - player.nameplate.length
    player.nameplate.concat(player.deck[0..nameplate_upper_limit])
    for i in 0..nameplate_upper_limit do
      player.deck.delete_at(0)
    end
  end

  def turn_end(player)
    player.energy = MAX_ENERGY if player.energy < MAX_ENERGY
    player.nameplate_to_cemetery if player.nameplate.length > 0
  end

  def next_battle_preparation(player)
    player.defense = 0
    player.energy = MAX_ENERGY
    player.deck.concat(player.nameplate).concat(player.cemetery)
    player.cemetery.clear
    player.nameplate.clear
  end

  def display_enemies_name(enemies)
    enemies.each do |enemy|
      puts "#{enemy.name}があらわれた"
    end
  end

  def display_nameplate(player)
    puts "カードを選んでください"
    result_message = ""
    player.nameplate.each.with_index(1) do |card, index|
      result_message += "#{index}: #{card.name} "
    end
    puts result_message
  end

  def display_player_status(player)
    puts "#{player.name}のHP:#{player.hp} 残りのエネルギー:#{player.energy} こうげき:#{player.attack} ぼうぎょ:#{player.defense}"
    puts "デッキ枚数:#{player.deck.length} 手札:#{player.nameplate.length} 墓地:#{player.cemetery.length}"
  end

  def display_enemy_status(enemies)
    enemies.each do |enemy|
      puts "#{enemy.name}のHP:#{enemy.hp} こうげき:#{enemy.attack} ぼうぎょ:#{enemy.defense}"
    end
  end

  def display_enemy_attack(enemy)
    puts "#{enemy.name}のターン"
    puts "こうげき"
  end

  def display_victory_result(enemies)
    enemies.each do |enemy|
      puts "#{enemy.name}をたおした"
    end
  end

  def display_defeat_result(player)
    puts "#{player.name}は力尽きた"
    puts "GAME OVER"
  end

  def display_defeated_enemy_message(enemy)
    puts "#{enemy.name}をたおした"
  end

  def calc_damage(character, attack)
    damage = character.defense - attack
    if damage < 0
      damage = damage.abs
      character.defense = 0
    else
      character.defense -= attack
      damage = 0
    end
    damage
  end

  def calc_remaining_hp(character, damage)
    character.hp -= damage
  end

  def is_zero_hp(character)
    character.hp <= 0 ? true : false
  end

  def is_annihilate_enemies(enemies)
    total_deaths = []
    enemies.each do |enemy|
      is_annihilate = enemy.hp <= 0 ? true : false
      total_deaths.push(is_annihilate)
    end
    total_deaths.all?
  end
end
