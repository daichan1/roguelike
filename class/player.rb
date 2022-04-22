class Player
  attr_accessor :name, :hp, :attack, :defense, :energy, :deck, :nameplate, :cemetery
  DEFAULT_DECK = Array.new(5, Fight.new).concat(Array.new(5, Protection.new))

  def initialize(name)
    @name = name
    @hp = 50
    @attack = 0
    @defense = 0
    @energy = 3
    @deck = DEFAULT_DECK
    @nameplate = []
    @cemetery = []
  end

  def status_initialize
    @hp = 50
    @attack = 0
    @defense = 0
    @energy = 3
    @deck = DEFAULT_DECK
    @nameplate = []
    @cemetery = []
  end

  def deck_preparation
    deck_replenishment
    deck_shuffle
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
