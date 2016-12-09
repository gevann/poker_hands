module PokerValues
  SUITS = %i(h d s c).freeze
  NMAP = {
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9,
    ten: 10,
    jack: 11,
    "J": 11,
    queen: 12,
    "Q": 12,
    king: 13,
    "K": 13,
    ace: 14,
    "A": 14,
  }

  def card_value(name)
    x = name.to_s.to_i
    if x > 0
      x
    else
      NMAP[name]
    end
  end
end
