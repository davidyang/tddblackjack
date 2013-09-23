#this is a naive strategy that should not be used in a casino
class Strategy
    def initialize(game)
        @player = game.player
    end

    def action
        raise "Need to use as subclass"
    end
end