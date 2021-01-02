class Card

    attr_writer :name
    attr_accessor :messages, :is_reversed

    def initialize( name, messages, is_reversed = false )
        @name = name
        @messages = messages
        @is_reversed = is_reversed
    end

    def major_arcana?
        @name.include?( ":" )
    end

    def name
        return @name if !is_reversed
        split_name = @name.split( " " )
        split_name.insert( split_name.length == 2 ? 1 : 2, "REVERSED" ) if self.major_arcana?
        split_name.insert( 1, "REVERSED" ) if !self.major_arcana?
        split_name.join( " " )
    end

end
