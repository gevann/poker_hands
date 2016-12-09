require_relative 'card'
require_relative 'poker_hands'

describe "poker hand comparisons" do
  def hand(vals, suits)
    BaseHand.new( vals.zip(suits).map { |x, y| Card.new(x, y) } )
  end

  let(:hearts) { [:h] * 5 }
  let(:clubs) { [:c] * 5 }
  let(:diamonds) { [:d] * 5 }
  let(:spades) { [:s] * 5 }
  let(:mixed_suits) { %i(h d s c h) }

  let(:straight_flush) { hand(%w(ten jack queen king ace), hearts) }
  let(:straight_flush_1) { hand(%w(ten jack queen king ace), hearts) }
  let(:straight_flush_2) { hand(%w(nine ten jack queen king), hearts) }

  let(:four_of_a_kind) { hand([2,2,2,2, :king], mixed_suits) }
  let(:four_of_a_kind_1) { hand([2,2,2,2, :king], mixed_suits) }
  let(:four_of_a_kind_2) { hand([3,3,3,3, :king], mixed_suits) }
  let(:four_of_a_kind_3) { hand([2,2,2,2, :ace], mixed_suits) }

  let(:full_house) { hand([2, 2, 3, 3, 3], hearts) }
  let(:full_house_1) { hand([2, 2, 3, 3, 3], hearts) }
  let(:full_house_2) { hand([2, 2, 4, 4, 4], hearts) }
  let(:full_house_4) { hand([5, 5, 3, 3, 3], hearts) }

  let(:flush)   { hand([2, 10, 3, 6, 9], hearts) }
  let(:flush_1) { hand([2, 10, 3, 6, 9], hearts) }
  let(:flush_2) { hand([2, :jack, 3, 6, 9], hearts) }
  let(:flush_3) { hand([2, 10, 3, 5, 9], hearts) }

  let(:straight)   { hand([*(3..7)], mixed_suits) }
  let(:straight_1) { hand([*(3..7)], mixed_suits) }
  let(:straight_2) { hand([*(4..8)], mixed_suits) }
  let(:straight_3) { hand([*(2..6)], mixed_suits) }

  let(:three_of_a_kind)   { hand([3, 3, 3, 4, 5], mixed_suits) }
  let(:three_of_a_kind_1) { hand([3, 3, 3, 4, 5], mixed_suits) }
  let(:three_of_a_kind_2) { hand([4, 4, 4, 5, 6], mixed_suits) }
  let(:three_of_a_kind_3) { hand([3, 3, 3, 2, 5], mixed_suits) }

  let(:two_pair)   { hand([3, 3, 4, 4, 5], mixed_suits) }
  let(:two_pair_1) { hand([3, 3, 4, 4, 5], mixed_suits) }
  let(:two_pair_2) { hand([4, 4, 5, 5, 6], mixed_suits) }
  let(:two_pair_3) { hand([3, 3, 2, 2, 5], mixed_suits) }

  let(:pair)   { hand([4, 4, 6, 5, 3], mixed_suits) }
  let(:pair_1) { hand([4, 4, 6, 5, 3], mixed_suits) }
  let(:pair_2) { hand([5, 5, 6, 6, 3], mixed_suits) }
  let(:pair_3) { hand([4, 4, 5, 3, 2], mixed_suits) }

  let(:high_card)   { hand(%i(ace two four six eight), mixed_suits) }
  let(:high_card_1) { hand(%i(ace two four six eight), mixed_suits) }
  let(:high_card_2) { hand(%i(ace two four six nine), mixed_suits) }
  let(:high_card_3) { hand(%i(ace two four six seven), mixed_suits) }

  context "comparing with a straight-flush" do
    subject { straight_flush }
    it { is_expected.to eq straight_flush_1 }
    it { is_expected.to be > straight_flush_2 }
    it { is_expected.to be > full_house }

    it { is_expected.to be > four_of_a_kind }
    it { is_expected.to be > full_house }
    it { is_expected.to be > flush }
    it { is_expected.to be > straight }
    it { is_expected.to be > three_of_a_kind }
    it { is_expected.to be > two_pair }
    it { is_expected.to be > pair }
    it { is_expected.to be > high_card }
  end

  context "comparing with a four of a kind" do
    subject { four_of_a_kind }

    it { is_expected.to eq four_of_a_kind_1 }
    it { is_expected.to be < four_of_a_kind_2 }
    it { is_expected.to be < four_of_a_kind_3 }

    it { is_expected.to be > full_house }
    it { is_expected.to be > flush }
    it { is_expected.to be > straight }
    it { is_expected.to be > three_of_a_kind }
    it { is_expected.to be > two_pair }
    it { is_expected.to be > pair }
    it { is_expected.to be > high_card }
  end

  context "comparing with a full-house" do
    subject { full_house }

    it { is_expected.to eq full_house_1 }
    it { is_expected.to be < full_house_2 }
    it { is_expected.to be < full_house_4 }
    it { is_expected.to be < full_house_4 }

    it { is_expected.to be > flush }
    it { is_expected.to be > straight }
    it { is_expected.to be > three_of_a_kind }
    it { is_expected.to be > two_pair }
    it { is_expected.to be > pair }
    it { is_expected.to be > high_card }
  end

  context "comparing with a flush" do
    subject { flush }

    it { is_expected.to eq flush_1 }
    it { is_expected.to be < flush_2 }
    it { is_expected.to be > flush_3 }

    it { is_expected.to be > straight }
    it { is_expected.to be > three_of_a_kind }
    it { is_expected.to be > two_pair }
    it { is_expected.to be > pair }
    it { is_expected.to be > high_card }
  end

  context "comparing with a straight" do
    subject { straight }

    it { is_expected.to eq straight_1 }
    it { is_expected.to be < straight_2 }
    it { is_expected.to be > straight_3 }

    it { is_expected.to be > three_of_a_kind }
    it { is_expected.to be > two_pair }
    it { is_expected.to be > pair }
    it { is_expected.to be > high_card }
  end

  context "comparing with a three_of_a_kind" do
    subject { three_of_a_kind }

    it { is_expected.to eq three_of_a_kind_1 }
    it { is_expected.to be < three_of_a_kind_2 }
    it { is_expected.to be > three_of_a_kind_3 }
    it { is_expected.to be > two_pair }
    it { is_expected.to be > pair }
    it { is_expected.to be > high_card }
  end

  context "comparing with a two_pair" do
    subject { two_pair }

    it { is_expected.to eq two_pair_1 }
    it { is_expected.to be < two_pair_2 }
    it { is_expected.to be > two_pair_3 }
    it { is_expected.to be > pair }
    it { is_expected.to be > high_card }
  end

  context "comparing with a pair" do
    subject { pair }
    it { is_expected.to eq pair_1 }
    it { is_expected.to be < pair_2 }
    it { is_expected.to be > pair_3 }
    it { is_expected.to be > high_card }
  end

  context "comparing with a high_card" do
    subject { high_card }
    it { is_expected.to eq high_card_1 }
    it { is_expected.to be < high_card_2 }
    it { is_expected.to be > high_card_3 }
  end

end
