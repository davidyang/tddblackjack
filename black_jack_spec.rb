require './black_jack'
require './person'

describe "Game" do

  # before each test, create a new @game
  before(:each) do
    @game = Game.new()
    @ace_card = Deck::Card[:value => 11, :suit => :clubs, :card => "ace"]
    @ten_card = Deck::Card[:value => 10, :suit => :clubs, :card => "ten"]
    @five_card = Deck::Card[:value => 5, :suit => :clubs, :card => 5]
  end

  it "has an attribute called shoe_size of 6" do
    expect(@game.shoe_size).to eq(6) 
  end

  it 'generates a deck of of shoe_size * 52 when initialized' do
    expect(@game.deck.size).to eq(52*@game.shoe_size)
  end

  it "creates a shuffled deck" do
    expect(@game.deck).not_to eq(Deck.new * 6)
  end

  it 'starts with a player and a dealer' do
    expect(@game.player).not_to be_nil
    expect(@game.dealer).not_to be_nil
    expect(@game.player).to be_a_kind_of(Person)
  end

  it 'deals two cards to each player' do
    @game.deal
    expect(@game.player.cards.size).to eq(2)
    expect(@game.dealer.cards.size).to eq(2)
  end

  describe "while dealing" do
    it "creates a new deck if there are less than 1/4 of the cards remaining" do 
      (52*6*3/4 + 10).times do 
        @game.deck.pop
      end
      @game.deal
      expect(@game.deck.size).to be_within(20).of(312)

    end

    it "gives the player two cards from the deck" do 
      expected_cards = [@game.deck.slice(-1), @game.deck.slice(-3)]
      @game.deal
      expect(@game.player.cards).to eq(expected_cards)
    end

    it "gives the dealer two cards from the deck" do
      expected_cards = [@game.deck.slice(-2), @game.deck.slice(-4)]
      @game.deal
      expect(@game.dealer.cards).to eq(expected_cards)     
    end
  end

  describe "while playing" do
    before(:each) do
      @game.deal
      @blackjack = [@ace_card, @ten_card]
    end

    it "returns nil if the player and dealer both have blackjack" do 
      @game.player.cards = @blackjack
      @game.dealer.cards = @blackjack
      expect(@game.play).to be_nil
    end

    it "returns the player object as the winner if the player has blackjack" do
      @game.player.cards = @blackjack
      @game.dealer.cards = [@ace_card]
      expect(@game.play).to be(@game.player)
    end


    it "returns the dealer object as the winner if the dealer has blackjack" do 
      @game.dealer.cards = @blackjack
      @game.player.cards = [@ace_card]
      expect(@game.play).to be(@game.dealer)
    end

    it "should return the dealer if the player busts" do
      @game.dealer.cards = [@ten_card] * 2
      @game.player.cards = [@ten_card] * 3
      expect(@game.evaluate_winner).to be(@game.dealer)
    end

    it "should return the player if the dealer busts" do 
      @game.player.cards = [@ten_card] * 2
      @game.dealer.cards = [@ten_card] * 3
      expect(@game.evaluate_winner).to be(@game.player)
    end

    it "should return the player if the dealer's total is < the player's total" do 
      @game.player.cards = [@ten_card, @five_card] 
      @game.dealer.cards = [@ten_card] * 2
      expect(@game.evaluate_winner).to be(@game.dealer)
    end

    it "returns the player object as the winner if the player has blackjack" do

    end

    it "should return nil if the player and the dealer have the same total" do
    end
  end

  describe "while playing on Person's hand using .play_hand" do
    it "should obey the player's strategy" do 
      @game.player.cards = [@five_card, @five_card]
      @game.player.strategy = AlwaysHitStrategy.new(@game)
      @game.play
      expect(@game.player.total).to be >= 21
      
    end

    it "should only add cards to the player's hand until the player says stand or busts" do
      @game.player.strategy = AlwaysHitStrategy.new(@game)
      expect(@game.player.strategy).to receive(:action).and_return(:stand)
      expect(@game.player.cards).not_to receive(:<<)
      @game.play

    end
  end
end

