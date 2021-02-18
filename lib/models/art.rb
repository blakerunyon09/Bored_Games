class Artwork

    #THIS CLASS CONTAINS ALL ARTWORK FOR USE DURING THE APPLICATION, CAN USE ARTWORK.METHOD MADE TO CALL THEM INTO CLI APP
    def self.title
        font = TTY::Font.new(:starwars)
        pastel = Pastel.new
        puts pastel.magenta.bold(font.write("Bored"))
        puts pastel.magenta.bold(font.write("Games"))
        puts pastel.yellow.bold("When you don't know what to play")
        puts pastel.yellow.bold("Let us help!!")

    end

    def self.progress_bar
        pastel = Pastel.new
        bar = TTY::ProgressBar.new(pastel.yellow.bold("Getting epic game [:bar]"), total: 30, bar_format: :button)
        30.times do
            sleep(0.1)
            bar.advance
        end
    end
    def self.bored_game
        font = TTY::Font.new(:starwars)
        pastel = Pastel.new
        puts pastel.magenta.bold(font.write("Bored"))
        puts pastel.magenta.bold(font.write("Games"))
    end
    def self.goodbye
        font = TTY::Font.new(:starwars)
        pastel = Pastel.new
        puts pastel.magenta.bold(font.write("GOODBYE"))
    end

end
