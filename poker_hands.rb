class BaseHand
  include Comparable
  SCORE = 0

  attr_reader :cards

  def initialize(cs)
    @cards = cs
  end

  def <=>(anOther)
    if self.class::SCORE > anOther.class::SCORE
      1
    elsif self.class::SCORE < anOther.class::SCORE
      -1
    else
      tie_breaker(anOther)
    end
  end

  def tie_breaker(anOther)
    if self.high_card > anOther.high_card
      1
    elsif
      self.high_card < anOther.high_card
      -1
    else
      0
    end
  end

  def high_card
    @cards.sort.last
  end
end

class StraightFlush < BaseHand
  SCORE = 9
end

class FourOfAKind < BaseHand
  SCORE = 8
end

class FullHouse < BaseHand
  attr_reader :three_value
  attr_reader :pair_value

  SCORE = 7

  def initialize(cs, three_value, pair_value)
    @cards = cs
    @three_value = three_value
    @pair_value = pair_value
  end

  def tie_breaker(anOther)
    if self.three_value > anOther.three_value
      1
    elsif self.three_value < anOther.three_value
      -1
    else
      # tie on 3 of a kind, check pair values
      if self.pair_value > anOther.pair_value
        1
      elsif self.pair_value < anOther.pair_value
        -1
      else
        0
      end
    end
  end
end

class Flush < BaseHand
  SCORE = 6
end

class Straight < BaseHand
  SCORE = 5
end

class ThreeOfAKind < BaseHand
  SCORE = 4

  def initialize(cs, three_value, pair_value)
    @cards = cs
    @three_value = three_value
  end

  def tie_breaker(anOther)
    if self.three_value > anOther.three_value
      1
    elsif self.three_value < anOther.three_value
      -1
    else
      0
    end
  end
end

class TwoPair < BaseHand
  SCORE = 3
  attr_reader :major_pair_value
  attr_reader :minor_pair_value
  attr_reader :single_card_value

  def initialize(cs, major_pair_value, minor_pair_value)
    @cards = cs
    @major_pair_value = major_pair_value
    @minor_pair_value = minor_pair_value
    @single_card_value = @cards.reject do
      |c| c.value == @major_pair_value || c.value == @minor_pair_value
    end.flatten.last
  end

  def tie_breaker(anOther)
    if self.major_pair_value > anOther.major_pair_value
      1
    elsif self.major_pair_value < anOther.major_pair_value
      -1
    else
      #tie on major pair
      if self.minor_pair_value > anOther.minor_pair_value
        1
      elsif self.minor_pair_value < anOther.minor_pair_value
        -1
      else
        #tie on minor pair as well
        if self.single_card_value > anOther.single_card_value
          1
        elsif self.single_card_value < anOther.single_card_value
          -1
        else
          #tie on single remaining card as well
          0
        end
      end
    end
  end
end

class TwoOfAKind < BaseHand
  SCORE = 2
  attr_reader :pair_value
  attr_reader :kicker

  def initialize(cs, pair_value)
    @cards = cs
    @pair_value = pair_value
    @kicker = @cards.reject { |c| c.value == @pair_value }
  end

  def tie_breaker(anOther)
    if self.pair_value > anOther.pair_value
      1
    elsif self.pair_value < anOther.pair_value
      -1
    else
      kicker = self.kicker.dup.sort!
      anOther_kicker = anOther.kicker.dup.sort!
      while (kicker.count > 0 && anOther_kicker.count > 0) do
        if kicker.max > anOther_kicker.max
          return 1
        elsif kicker.max < anOther_kicker.max
          return -1
        else
          kicker.pop
          anOther_kicker.pop
        end
        return 0
      end
    end
  end
end

class HighCard < BaseHand
  SCORE = 1
end
