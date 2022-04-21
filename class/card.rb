class Card
  attr_accessor :name, :cost, :type, :attack, :defense, :eff

  def action(player)
    is_useful = false
    if is_remaining_energy(player)
      is_useful = true
      player.attack = attack
      player.defense += defense
      player.energy -= cost
    else
      return is_useful
    end
    is_useful
  end

  def is_remaining_energy(player)
    remaining_energy = player.energy - cost
    remaining_energy >= 0 ? true : false
  end
end

class Fight < Card
  def initialize
    @name = "たたかう"
    @cost = 1
    @type = "アタック"
    @attack = 6
    @defense = 0
    @eff = "敵にこうげきをする"
  end
end

class Protection < Card
  def initialize
    @name = "ぼうぎょ"
    @cost = 1
    @type = "スキル"
    @attack = 0
    @defense = 5
    @eff = "敵のこうげきを防ぐ"
  end
end
