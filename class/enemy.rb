class Enemy
  attr_accessor :name, :hp, :attack, :defense
end

class Slime < Enemy
  def initialize
    @name = "スライム"
    @hp = 10
    @attack = 5
    @defense = 0
  end
end

class Goblin < Enemy
  def initialize
    @name = "ゴブリン"
    @hp = 16
    @attack = 7
    @defense = 1
  end
end
