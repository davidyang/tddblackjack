require './person'
require './deck'
require './strategy'

Dir["./strategy/*.rb"].each {|file| require file }

class Game
  attr_accessor :deck, :player, :dealer, :last_hand, :silent, :shoe_size

  def initialize
    @silent = false
    self.deck = create_deck
    self.player = Player.new
    self.player.strategy = Strategy.new(self) 

    self.dealer = Dealer.new("Dealer")
    self.dealer.strategy = DealerStrategy.new(self)

    @last_hand = false
  end

  def create_deck
  end

  def deal
  end


  # Check for certain game conditions like blackjack (or blackjack push)
  # Otherwise play the player's hand first and then the dealer's hand
  # Check who wins and return either the player/dealer winner (or nil if it's a push)
  def play
  end

  # given a player (and a player's strategy)
  # play their hand until the strategy says to :stand 
  # or the player busts
  def play_hand(player) 
  end

end
