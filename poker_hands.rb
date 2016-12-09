class BaseHand
  include Comparable

  HAND_ORDER = %w(StraightFlush FourOfAKind FullHouse Flush Straight ThreeOfAKind TwoPair TwoOfAKind HighCard).freeze
  attr_reader :cards, :rank

  def initialize(cs)
    @cards = cs
  end

  def <=>(anOther)
    if self.rank > anOther.rank
      1
    elsif self.rank < anOther.rank
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

  def rank
    -1 * HAND_ORDER.index(self.class.name)
  end
end

class StraightFlush < BaseHand; end
class FourOfAKind < BaseHand; end
class FullHouse < BaseHand; end
class Flush < BaseHand; end
class Straight < BaseHand; end
class ThreeOfAKind < BaseHand; end
class TwoPair < BaseHand; end
class TwoOfAKind < BaseHand; end
class HighCard < BaseHand; end
