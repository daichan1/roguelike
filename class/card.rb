class Card
  attr_accessor :name, :cost, :type, :atk, :def, :eff
end

class Fight < Card
  def initialize
    @name = "たたかう"
    @cost = 1
    @type = "アタック"
    @atk = 6
    @def = 0
    @eff = "敵にこうげきをする"
  end
end

class Protection < Card
  def initialize
    @name = "ぼうぎょ"
    @cost = 1
    @type = "スキル"
    @atk = 0
    @def = 5
    @eff = "敵のこうげきを防ぐ"
  end
end
