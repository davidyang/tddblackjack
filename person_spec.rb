require './black_jack'
require './person'


describe Person do

  before(:each) do
    @person = Person.new("David")
    @ace_card = Deck::Card[:value => 11, :suit => :clubs, :card => "ace"]
    @ten_card = Deck::Card[:value => 10, :suit => :clubs, :card => "ten"]
    @five_card = Deck::Card[:value => 5, :suit => :clubs, :card => 5]
  end

  it "can be initialized with an optional name argument" do
    expect(@person.name).to eq("David")
  end

  it "should be able to set an strategy attribute" do 
    expect(@person).to respond_to(:strategy=)
  end

  it "holds cards in an array called cards" do
    expect(@person.cards).to be_instance_of(Array)
  end

  it "can get a total point value of its cards using .total" do
    expect(@person.total).to eq(0)
    @person.cards << Deck::Card[:value => 11, :suit => :clubs, :card => "ace"]
    expect(@person.total).to eq(11)
  end

  it "knows if it has blackjack using .blackjack?" do 
    @person.cards = [@ace_card, @ten_card]
    expect(@person.blackjack?).to be_true
  end

  it "knows it it has busted using .busted?" do
    @person.cards = [@ten_card, @ten_card, @ten_card]
    expect(@person.busted?).to be_true
    @person.cards = [@ten_card, @ten_card]
    expect(@person.busted?).to be_false
  end

  it "knows how to use a soft ace" do 
    @person.cards = [@ten_card, @five_card, @ace_card]
    expect(@person.busted?).to be_false

    @person.cards = [@ace_card] * 3
    expect(@person.busted?).to be_false

  end

  it "prints out its name and card total using .to_s" do
    @person.cards = [@ace_card] * 3
    expect(@person.to_s).to eq("David 33")
  end
end

describe Player do 
  it "is a subclass of Person" do 
    expect(Player.new).to be_a_kind_of(Person)
  end
end

describe Dealer do
  it "is a subclass of Person" do 
    expect(Dealer.new).to be_a_kind_of(Person)
  end
end
