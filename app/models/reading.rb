class Reading

    attr_accessor :deck, :drawn, :reading_map, :spread

    def initialize( this_spread )
        @deck = File.open( "cards.txt" ).read.split( "\n" ).each_slice(3).to_a.map{ | card | Card.new( card[ 0 ], [ card[ 1 ], card [ 2 ] ] ) }
        @drawn = []
        @reading_map = {}
        @spread = this_spread
    end

    def shuffle_deck
        self.deck.each{ | card | card.is_reversed = [ true, false ].sample }
        self.deck.shuffle!
    end

    def draw
        self.shuffle_deck
        self.drawn = self.deck.pop( self.spread.length )
        self.spread.each_with_index do | card_in_spread, i |
            card_meaning = self.drawn[ i ].is_reversed ? self.drawn[ i ].messages[ 1 ] : self.drawn[ i ].messages[ 0 ]
            reading_map[ card_in_spread ] = { name: self.drawn[ i ].name, meaning: card_meaning }
        end
    end

end
