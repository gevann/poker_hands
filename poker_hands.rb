require_relative 'hand_builder'

class BaseHand
  include Comparable
  include HandBuilder

  HAND_ORDER = %w(straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pair two_of_a_kind high_card).freeze

  attr_reader :cards, :rank, :type

  def initialize(cs)
    cs.each do |card|
      raise ArgumentError.new("#{card.inspect} is not a Card object") unless card.is_a? Card
    end
    @cards = cs
    @type = set_hand_type(@cards)
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
    -1 * HAND_ORDER.index(self.type)
  end
end
