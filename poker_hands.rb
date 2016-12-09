class BaseHand
  include Comparable

  attr_reader :cards

  def initialize(cs)
    @cards = cs
  end

  def <=>(anOther)
    if self.class > anOther.class
      1
    elsif self.class < anOther.class
      -1
    else
      tie_breaker(anOther)
    end
  end

  def grouped
    self.cards.group_by(&:value).sort_by { |k, v| -v.count }.flatten.reject { |x| x.is_a? Card }
  end

  def tie_breaker(anOther)
    self.grouped.zip(anOther.grouped).map do |x, y|
      return 1 if x > y
      return -1 if x < y
    end
      0
  end
end

class StraightFlush < BaseHand
end

class FourOfAKind < StraightFlush
end

class FullHouse < FourOfAKind
end

class Flush < FullHouse
end

class Straight < Flush
end

class ThreeOfAKind < Straight
end

class TwoPair < ThreeOfAKind
end

class TwoOfAKind < TwoPair
end

class HighCard < TwoOfAKind
end
