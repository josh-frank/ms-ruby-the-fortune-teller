class Tarot

    def run
        system "clear"
        interface = Interface.new
        interface.welcome
        spread = interface.choose_spread
        reading = Reading.new( spread )
        reading.draw
        interface.read_spread( reading )
        interface.goodbye
    end
    
end
