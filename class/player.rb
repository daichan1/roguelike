class Player
  attr_accessor :name, :hp, :atk, :def, :en, :deck, :nameplate, :cemetery
  def initialize(name)
    @name = name
    @hp = 50
    @atk = 0
    @def = 0
    @en = 3
    @deck = Array.new(DEFAULT_CARD_LENGTH, Fight.new)
    @nameplate = []
    @cemetery = []
  end

  def status_initialize
    @hp = 50
    @atk = 0
    @def = 0
    @en = 3
    @deck = Array.new(DEFAULT_CARD_LENGTH, Fight.new)
    @nameplate = []
    @cemetery = []
  end

  def deck_replenishment
    if deck.length >= 1
      nameplate.concat(deck)
      deck.clear
    end
    deck.concat(cemetery)
    cemetery.clear
  end

  def nameplate_to_cemetery
    cemetery.concat(nameplate)
    nameplate.clear
  end

  def deck_shuffle
    deck.shuffle!
  end
end
