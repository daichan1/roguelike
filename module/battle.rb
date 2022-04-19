module Battle
  def start(player, enemy, game_continue)
    puts "#{enemy.name}があらわれた"
    combat_continuity = true
    player.deck_shuffle
    while combat_continuity do
      player_turn(player, enemy)

      if is_zero_hp(enemy)
        display_victory_result(enemy)
        next_battle_preparation(player)
        return game_continue
      end

      enemy_turn(player, enemy)

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

  def player_turn(player, enemy)
    puts "#{player.name}のターン"
    turn_continue = true
    if player.deck.length < DEFAULT_DECK_LENGTH
      player.deck_replenishment
      player.deck_shuffle
    end
    card_draw(player)
    while turn_continue && player.energy > 0 do
      display_player_status(player)
      card_number = card_select(player)
      card = player.nameplate[card_number - 1]
      player.cemetery.push(card)
      player.nameplate.delete_at(card_number - 1)
      puts card.name

      card.action(player)
      damage = calc_damage(player.attack, enemy.defense)
      puts "#{damage}のダメージをあたえた"
      calc_remaining_hp(enemy, damage)

      return if is_zero_hp(enemy)

      turn_continue = turn_select(turn_continue)
    end
    player.energy = MAX_ENERGY if player.energy < MAX_ENERGY
    player.nameplate_to_cemetery if player.nameplate.length > 0
  end

  def enemy_turn(player, enemy)
    display_enemy_attack(enemy)
    damage = calc_damage(enemy.attack, player.defense)
    puts "#{damage}のダメージをうけた"
    calc_remaining_hp(player, damage)
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

  def card_draw(player)
    nameplate_upper_limit = DEFAULT_NAMEPLATE_LENGTH - player.nameplate.length
    player.nameplate.concat(player.deck[0..nameplate_upper_limit])
    for i in 0..nameplate_upper_limit do
      player.deck.delete_at(0)
    end
  end

  def next_battle_preparation(player)
    player.defense = 0
    player.energy = MAX_ENERGY
    player.deck = Array.new(DEFAULT_CARD_LENGTH, Fight.new)
    player.cemetery.clear
    player.nameplate.clear
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
    puts "#{player.name}のHP:#{player.hp} 残りのエネルギー:#{player.energy}"
    puts "デッキ枚数:#{player.deck.length} 手札:#{player.nameplate.length} 墓地:#{player.cemetery.length}"
  end

  def display_enemy_attack(enemy)
    puts "#{enemy.name}のターン"
    puts "こうげき"
  end

  def display_victory_result(enemy)
    puts "#{enemy.name}をたおした"
  end

  def display_defeat_result(player)
    puts "#{player.name}は力尽きた"
    puts "GAME OVER"
  end

  def calc_damage(attack, defense)
    damage = attack - defense
    damage < 0 ? 0 : damage
  end

  def calc_remaining_hp(character, damage)
    character.hp -= damage
  end

  def is_zero_hp(character)
    character.hp <= 0 ? true : false
  end
end
