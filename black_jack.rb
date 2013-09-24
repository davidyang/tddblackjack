require './person'
require './deck'
require './strategy'

Dir["./strategy/*.rb"].each {|file| require file }

class Game
  attr_accessor :deck, :player, :dealer, :last_hand, :silent, :shoe_size

  def initialize
    @silent = false

    self.shoe_size = 6

    self.deck = create_deck
    self.player = Player.new
    self.player.strategy = Strategy.new(self) 

    self.dealer = Dealer.new("Dealer")
    self.dealer.strategy = DealerStrategy.new(self)

    @last_hand = false
  end

  def create_deck
    full_deck = []
    self.shoe_size.times do 
      full_deck += Deck.new
    end
    7.times do 
      full_deck.shuffle!
    end
    full_deck
  end

  def deal
    if self.deck.size < 312/4
      self.deck = create_deck
    end

    2.times do 
      self.player.cards << self.deck.pop
      self.dealer.cards << self.deck.pop
    end
  end


  # Check for certain game conditions like blackjack (or blackjack push)
  # Otherwise play the player's hand first and then the dealer's hand
  # Check who wins and return either the player/dealer winner (or nil if it's a push)
  def play
    if self.player.blackjack? && self.dealer.blackjack?
      return nil
    elsif self.player.blackjack?
      return self.player
    elsif self.dealer.blackjack?
      return self.dealer
    end

    play_hand(self.player)
    play_hand(self.dealer)

    evaluate_winner
  end

  def evaluate_winner
    if self.player.busted?
      return self.dealer
    elsif self.dealer.busted? || self.player.total > self.dealer.total
      return self.player
    elsif self.player.total == self.dealer.total 
      return nil
    elsif self.player.total < self.dealer.total
      return self.dealer
    end
  end

  # given a player (and a player's strategy)
  # play their hand until the strategy says to :stand 
  # or the player busts
  def play_hand(player) 
    while player.strategy.action == :hit && !player.busted?
      player.cards << self.deck.pop
    end
  end

end
