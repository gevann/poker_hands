describe "poker hands" do
  require_relative 'card'
  require_relative 'hand_builder'

  include HandBuilder

  let(:hearts) { [:h] * 5 }
  let(:straight_flush) do
    build_hand(%w(ten jack queen king ace).zip(hearts).map{ |x, y| Card.new(x, y) } )
  end
  let(:full_house) do
    build_hand([2, 2, 3, 3, 3].zip(hearts).map{ |x, y| Card.new(x, y) } )
  end
  let(:full_house_1) do
    build_hand([2, 2, 3, 3, 3].zip(hearts).map{ |x, y| Card.new(x, y) } )
  end
  let(:full_house_2) do
    build_hand([2, 2, 4, 4, 4].zip(hearts).map{ |x, y| Card.new(x, y) } )
  end

  it 'checks equality' do
    expect(full_house).to eq full_house_1
  end

  it 'chooses the full house with the larger three-of-a-kind' do
    expect(full_house).to be < full_house_2
  end

  it 'chooses straight flush over full house' do
    expect(straight_flush).to be > full_house
  end

  context "when two full-houses tie on three-of-a-kind" do
    let(:full_house_4) do
      build_hand([5, 5, 3, 3, 3].zip(hearts).map{ |x, y| Card.new(x, y) } )
    end
    it 'chooses the full house with the larger two-of-a-kind' do
      expect(full_house).to be < full_house_4
    end
  end
end
