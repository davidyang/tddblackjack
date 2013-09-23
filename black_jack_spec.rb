require './black_jack'
require './person'

describe "Game" do

  # before each test, create a new @game
  before(:each) do
    @game = Game.new()
  end

  it "has an attribute called shoe_size of 6" do
    pending
  end

  it 'generates a deck of of shoe_size * 52 when initialized' do
    pending
  end

  it "creates a shuffled deck" do
    pending
  end

  it 'has two players' do
    pending
  end

  it 'deals two cards to each player' do
    pending
  end

  describe "while dealing" do
    it "creates a new deck if there are less than 1/4 of the cards remaining" do 
      pending
    end

    it "gives the player two cards from the deck" do 
      pending
    end

    it "gives the dealer two cards from the deck" do
      pending
    end
  end

  describe "while playing" do
    it "returns nil if the player and dealer both have blackjack" do 
      pending
    end

    it "returns the player object as the winner if the player has blackjack" do
      pending
    end


    it "returns the dealer object as the winner if the dealer has blackjack" do 
      pending
    end

    it "should return the dealer if the player busts" do
      pending
    end

    it "should return the player if the dealer busts" do 
      pending
    end

    it "should return the player if the dealer's total is < the player's total" do 
      pending
    end

    it "returns the player object as the winner if the player has blackjack"
      pending
    end

    it "should return nil if the player and the dealer have the same total" do
      pending
    end
  end

  describe "while playing on Person's hand" do
    it "should obey the player's strategy" do 
      pending
    end

    it "should only add cards to the player's hand until the player says stand or busts" do
      pending
    end
  end
end

