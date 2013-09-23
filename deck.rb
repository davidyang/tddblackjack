# encoding: utf-8
class Deck < Array
    attr_accessor :cards
    SUITS = [:clubs, :diamonds, :hearts, :spades]
    
    def initialize
      super
      SUITS.each do |suit|
        ace = Card[:value => 11, :suit => suit, :card => "ace"]
        push(ace)

        (2..10).each do |n|
          card = Card[:value => n, :suit => suit, :card => n]
          push(card)
        end

        ["jack", "queen", "king"].each do |n|
          card = Card[:value => 10, :suit => suit, :card => n]
          push(card)
        end
      end

      self
    end

    class Card < Hash
      SYMBOLS = {
        :clubs =>     "♣",
        :diamonds =>  "♦",
        :hearts =>    "♥",
        :spades =>    "♠"
      }

      def soft_ace?
        self[:card] == 'ace' && self[:value] == 11
      end

      def to_s
        suit = SYMBOLS[self[:suit]]
        if self[:card].kind_of?(String)
          "#{self[:card][0,1].upcase}#{suit} "
        else
          "#{self[:card]}#{suit} "
        end
      end

      def inspect
        to_s
      end
    end
end