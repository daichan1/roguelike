class Card
  attr_accessor :name, :cost, :type, :atk, :def, :eff
  def initialize
    @name = "たたかう"
    @cost = 1
    @type = "アタック"
    @atk = 6
    @def = 0
    @eff = "敵にこうげきをする"
  end
end
