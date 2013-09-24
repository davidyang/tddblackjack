require_relative './always_hit_strategy'

describe AlwaysHitStrategy do
  it "should always hit" do
    game = Game.new
    @strategy = AlwaysHitStrategy.new(@game)
    expect(@strategy.action).to eq(:hit)
  end
end