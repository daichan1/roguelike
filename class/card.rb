class Card
  attr_accessor :name, :cost, :type, :attack, :defense, :eff

  def action(player)
    player.attack = attack
    player.defense += defense
    player.energy -= cost
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
