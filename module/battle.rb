def card_select
  card_number = 0
  card_decision = UN_CARD_SELECT
  while card_decision === UN_CARD_SELECT do
    puts "カードを選んでください(1:こうげき 2:ぼうぎょ 3:こうげき 4:ぼうぎょ 5:こうげき)"
    card_number = gets.to_i
    if CARD_CANDIDATE.include?(card_number)
      card_decision = CARD_SELECTED
    else
      puts "1,2,3,4,5のどれかを入力してください"
    end
  end
  card_number
end

def battle(player, enemy, deck, game_continue)
  puts "#{enemy.name}があらわれた"
  combat_continuity = true
  while combat_continuity do
    nameplate = deck[0..4]
    player_turn(player, nameplate, enemy)

    if is_zero_hp(enemy)
      display_victory_result(enemy)
      return game_continue
    end

    enemy_turn(player, enemy)

    if is_zero_hp(player)
      display_defeat_result(player)
      game_continue = false
      combat_continuity = false
    end
  end
  game_continue
end

def player_turn(player, nameplate, enemy)
    puts "#{player.name}のターン"
    turn_continue = true
    while turn_continue && player.en > 0 do
      display_player_status(player)
      card_number = card_select
      card = nameplate[card_number - 1]
      puts card.name

      attack = calc_player_attack(player, card)
      defense = enemy.def
      damage = calc_damage(attack, defense)
      calc_remaining_hp(enemy, damage)

      if is_zero_hp(enemy)
        energy_replenishment(player) if player.en < MAX_ENERGY
        return
      end

      calc_remaining_en(player, card)
      turn_continue = turn_select(turn_continue)
    end
    energy_replenishment(player) if player.en < MAX_ENERGY
end

def enemy_turn(player, enemy)
    display_enemy_attack(enemy)
    attack = enemy.atk
    defense = player.def
    damage = calc_damage(attack, defense)
    calc_remaining_hp(player, damage)
end

def display_player_status(player)
  puts "#{player.name}のHP:#{player.hp} 残りのエネルギー:#{player.en}"
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

def calc_player_attack(player, card)
  player.atk + card.atk
end

def calc_damage(attack, defense)
  attack - defense
end

def calc_remaining_hp(character, damage)
  character.hp -= damage
end

def calc_remaining_en(player, card)
  player.en -= card.cost
end

def is_zero_hp(character)
  character.hp <= 0 ? true : false
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

def energy_replenishment(player)
  for i in 1..(MAX_ENERGY - player.en) do
    player.en += 1
  end
end
