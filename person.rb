require './strategy'

class Person
  attr_accessor :strategy, :cards

  def initialize(name="")
    @name = name
    @cards = []
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end

  def blackjack?
    total == 21
  end

  def total
    running_total = 0
    self.cards.each do |card| # <-- Deck::Card {:value, :card, :suit}
      running_total += card[:value] # 
    end
    running_total
  end

  def can_use_a_soft_ace?
    self.cards.each do |card|
      if card[:card] == "ace" && card[:value] == 11
        return card
      end
    end
    nil
  end

  def busted?
    if total > 21
      ace = can_use_a_soft_ace?
      if(ace) # ace exists
        ace[:value] = 1
        return busted?
      else
        true
      end
    else
      false
    end
  end

  def to_s
    "#{self.name} #{self.total}"  
  end

end

class Player < Person
end

class Dealer < Person
end
