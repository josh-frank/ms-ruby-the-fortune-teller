class Interface

    attr_reader :prompt, :spreads, :ordinals, :templates

    def initialize
        @prompt = TTY::Prompt.new
        @spreads = {
            triad: [ "aspirations and fears", "assets and obstacles", "strategies and warnings" ],
            cross: [ "present situation", "current influences", "goals and destiny", "distant past", "recent past", "future influences", "current attitudes", "factors and challenges", "inner emotions", "final outcome" ],
            dawn: [ "life story", "ultimate nature", "question's ultimate nature", "current path", "alternative approaches", "state of mind", "uncontrollable outside influences", "current obstacles", "ways through", "burdens and their effects", "resolutions", "hopes and aspirations", "hidden desires", "ulterior motives", "final outcome" ],
            wheel: [ "charater and personality", "question/concern", "past", "near future", "private life", "public life", "self-image", "identity", "desires", "fears" ]
        }
        @ordinals = [ "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth" ]
        @templates = [ "This card often indicates *.", "It seems * may be a factor here.", "The shadow of * looms over this card.", "My word! This card could mean *!", "I see here signs of *.", "This is often the card of *.", "This card is a powerful sign of *.", "It's clearly an omen of *!", "Oh, my! This can mean *...", "I interpret * from this card.", "Yes, * may be possible here.", "This card points me to *.", "Consider if * is part of this issue.", "Is * what's happening here?", "Tradition holds this to be a card of *." ]
    end

    def welcome
        puts "Welcome, dear, come inside! They call me Ms. Ruby - I foresaw your arrival.\n\n"
        puts "Oh, my, you look troubled, my child! Worry not - the cards see all!\n\n"
    end

    def choose_spread
        spread_key = self.prompt.select("Now, think upon your question - think hard! And let us meditate upon the infinitude of the universe and the serene majesty of the cards as we choose a spread... ") do | menu |
            menu.choice "Triad", -> { :triad }
            menu.choice "Celtic Cross", -> { :cross }
            menu.choice "Golden Dawn", -> { :dawn }
            menu.choice "Wheel of Truth", -> { :wheel }
        end
        puts "\nAh, the #{ spread_key.to_s.capitalize }! Truly, you are a seeker of truth!\n\n"
        self.spreads[ spread_key ]
    end

    def read_spread( reading )
        puts "Now, clear your mind... relax... and with a pure heart and light in our souls, let us examine what the cards portend..."
        self.prompt.keypress("(Press any key)\n\n")
        reading.reading_map.each_with_index do | ( card_in_spread, card_contents ), card_number |
            system "clear"
            puts "Your #{ self.ordinals[ card_number ] } card represents your #{ card_in_spread }!"
            self.prompt.keypress("(Press any key)\n")
            puts "For this card you've drawn... #{ card_contents[ :name ] }!"
            self.prompt.keypress("(Press any key)\n")
            predictions = card_contents[ :meaning ].split( ". " )
            predictions.last.delete_suffix!(".")
            predictions.shuffle!
            while !predictions.empty? do
                puts self.templates.sample.gsub( "*", predictions.pop.downcase )
            end
            self.prompt.keypress("(Press any key)\n")
        end
        system "clear"
    end

    def goodbye
        puts "Our time together is through, my child! But fear not - I see a portent you will return to Ms. Ruby very soon, indeed...\n\n"
        puts "Until then, fare well! And remember - it is YOU, not the Tarot, who creates your future!\n\n"
    end

end
