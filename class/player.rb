class Player
  attr_accessor :name, :hp, :atk, :def, :en, :deck, :nameplate, :cemetery
  def initialize(name)
    @name = name
    @hp = 50
    @atk = 0
    @def = 0
    @en = 3
    @deck = Array.new(10, Card.new)
    @nameplate = []
    @cemetery = []
  end

  def status_initialize
    @hp = 50
    @atk = 0
    @def = 0
    @en = 3
    @deck = Array.new(10, Card.new)
    @nameplate = []
    @cemetery = []
  end
end
