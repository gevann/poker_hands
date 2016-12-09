class Card
  include Comparable
  require_relative 'poker_values'
  include PokerValues

  attr_reader :suit
  attr_reader :value

  def initialize(val, suit)
    raise ArgumentError.new("#{suit} is not a recognized suit.") unless PokerValues::SUITS.include? suit.to_sym
    @suit = suit.to_sym

    if (val.is_a? Integer)
      raise ArgumentError.new("#{val} is not a recognized card value.") unless (val <= 10 && val >= 2)
      @value = val
    else
      raise ArgumentError.new("#{val} is not a recognized card value.") unless PokerValues::NMAP.keys.include? val.to_sym
      @value = card_value(val.to_sym)
    end
  end

  def <=>(anOther)
    value <=> anOther.value
  end
end
