class Player
  attr_accessor :name, :hp, :atk, :def, :en
  def initialize(name)
    @name = name
    @hp = 50
    @atk = 0
    @def = 0
    @en = 3
  end
end
