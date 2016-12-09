module HandBuilder
  require_relative 'poker_hands'

  POKER_HANDS = %w(straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pair two_of_a_kind).freeze

  def build_hand(cards)
    cards.each do |card|
      raise ArgumentError.new("#{card.inspect} is not a Card object") unless card.is_a? Card
    end

    klass = Object.const_get(constantize(set_hand_type(cards)))
    klass.new(cards)
  end

  private

  def set_hand_type(cards)
    if type = POKER_HANDS.detect { |hand_type| self.send(hand_type + "?", cards) }
      type
    else
      'high_card'
    end
  end

  def constantize(str)
    str.split("_").map(&:capitalize).join
  end

  def straight_flush? cards
    straight?(cards) && flush?(cards)
  end

  def flush? cards
    cards.group_by(&:suit).map { |suit, grouping| grouping.count == cards.count }.any?
  end

  def straight? cards
    vals = cards.map(&:value)
    (vals.uniq.length == 5) && (vals.sort[0] - vals.sort[-1] == -4)
  end

  def four_of_a_kind? cards
    x_of_a_kind?(4, cards)
  end

  def full_house? cards
    three_of_a_kind?(cards) && pair_excluding?(x_of_a_kind(3, cards), cards)
  end

  def three_of_a_kind? cards
    x_of_a_kind?(3, cards)
  end

  def two_of_a_kind? cards
    x_of_a_kind?(2, cards)
  end

  def two_pair? cards
    two_of_a_kind?(cards) && pair_excluding?(x_of_a_kind(2, cards), cards)
  end

  # param x [Integer] the number of matching cards, by value, to look for.
  # param c [Array <Card>] the array of cards to search in.
  # return [Boolean] whether or not the array has x many matching cards (by value)
  def x_of_a_kind?(x, c)
    c.group_by(&:value).map { |value, grouping| grouping.count == x }.any?
  end

  # param x [Integer] the number of matching cards, by value, to look for.
  # param c [Array <Card>] the array of cards to search in.
  # return [Integer], [Array <Card>] the value of the x_of_kind, and the cards it consists of.
  def x_of_a_kind(x, c)
    c.group_by(&:value).select { |value, grouping| grouping.count == x }.flatten.last
  end

  def pair_excluding?(exclusion, cards)
    x_of_a_kind?(2, cards.reject { |c| c.value == exclusion.first.value })
  end

  def pair_excluding(exclusion, cards)
    x_of_a_kind(2, cards.reject { |c| c.value == exclusion.first.value })
  end
end
