##Signup/Loginn - VERY FIRST THING 
    ## Browse Games
    ## Find Your Perfect Game
    ## View your saved games
    ###???? try to view top 10 list for games 
class Cli  
    attr_accessor :user
    # puts "Bored Games"
    # puts "When you dont know what to play, let us help you!" 
    def initialize user=nil
        @user = user 
    end

    def prompt 
        TTY::Prompt.new
    end



    def start 
        user_input = prompt.yes? "Have you been here before?"
        if user_input
            sign_in
        else
            sign_up
        end
    end






    def sign_in 
        user_input = prompt.ask "What is your username?"
        found_user = User.find_by(username: user_input)
        if found_user
            @user = found_user 
            main_menu
        else
            puts "So Sorry Bud, that username doesn't exist. Let's sign you up!"
            sign_up
        end
    end
    def sign_up
        name = prompt.ask "What's your name?"
        username = prompt.ask "What's your username?"
        if User.all.pluck(:username).include?(username)
            puts "That username is taken, bud!"
            sign_up
        else
            self.user = User.create(
                name: name,
                username: username)

        end
        puts "Thanks! Let's go to the main menu!"
        main_menu
    end

    def main_menu
        system("clear")
        all_selection = ["Lets find your perfect match, bud", "Lets find you a rando, bud", "Add a game to the catalogue, bud", "Lets see ALL the games, bud", "See all your favorite games, bud"]
        main_selection = prompt.select("Welcome to the main menu, what would you like to do bud?", all_selection)
        case main_selection
        when "Lets find your perfect match, bud"
            puts "this is our quiz"
            return_or_exit

        when "Lets find you a rando, bud"
            rando_game = Boardgame.all.sample
            puts "#{rando_game.name} is a #{rando_game.difficulty} difficulty game to learn and play. It plays best with #{rando_game.ideal_number_of_players} buds and will take you about #{rando_game.duration} minutes to play!"
            add_to_fave = prompt.yes?("Would you like to add this to your favorite games?")
            if find_all_favorites.include?(rando_game.name)
                puts 'Thats already part of your favorites list bud!!'
                return_or_exit
            end
            
            if add_to_fave
                Usergame.create(user: @user, boardgame: rando_game)
            end
            return_or_exit

        when "Add a game to the catalogue, bud"
            puts "Bud, you are doing some good work, lets enter a new boardgame so other buds can access it as well"
            bg_name = prompt.ask("What is the name of the boardgame?")
            bg_players = prompt.ask("What is the ideal number of players?", convert: :integer)
            bg_difficulty = prompt.select("How hard is this game to learn and play?",["Easy", "Medium", "Hard"])
            bg_duration = prompt.ask("About how long does a game usually last (in minutes)?", convert: :integer)
            ##NEED TO MAKE A CHECK TO SEE IF GAME ALREADY EXISTS
            Boardgame.create(name: bg_name, duration: bg_duration, difficulty: bg_difficulty, ideal_number_of_players: bg_players)

            puts "Thats awesome!! Your game has now been added so all the other buds can see it too! \n"

            return_or_exit

        when "Lets see ALL the games, bud"  
            ##POSSIBLE TO MAKE INTO A TABLE TO VIEW ALL OF THE BOARDGAMES AND INFORMATION ABOUT THEM!
            Boardgame.all.each do |game|
                puts game.name
            end
            return_or_exit

        when "See all your favorite games, bud"
            find_all_favorites.each do |game|
                puts game
            end
            return_or_exit
        end
    end




    def find_all_favorites
        all_faves = Usergame.all.filter do |user_fav|
            user_fav.user == @user
        end
        named_faves = all_faves.map do |favorite|
            favorite.boardgame.name
        end

    end




    ##TO PUT AT END OF MENU CHOICES TO GO BACK OR EXIT
    def return_or_exit
        what_to_do = prompt.select("What would you like to do now, bud?",["Return to the main menu", "Exit"])
        if what_to_do == "Return to the main menu"
            system('clear')
            main_menu
        else
            puts "Thanks for stopping by buddy!"
            exit!
        end

    end






end





    #LAYOUT
    #IS THIS YOUR FIRST TIME HERE?
    #IF SO TAKE TO SIGN UP, IF NOT TAKE TO 'LOGIN' SCREEN

    #SIGNUP -- PROMPT.ASK TO GET FIRST NAME AND USERNAME
    #LOGGING -- INPUT THEIR USERNAME AND SET THE USER AND USERNAME; CAN LIKELY USE FINDBY 

    #AFTER LOGGING IN HAVE OPTIONS:
        #LET US RANDOMLY SELECT A GAME!
        #DO THE QUIZ TO HELP US SELECT GAME 
            #HOW MANY PLAYERS DO YOU HAVE?
            #WHAT IS YOUR TIME LIMIT?
            #HOW CHALLENGING WOULD YOU LIKE THE GAME TO BE?
            #LOADING BAR? MAYBE WITH LIKE LITTLE BOARD GAMES LIKE THEY HAD TACOS??
            #OUTPUT THE GAME, OR SAY SORRY AT THIS TIME NO GAME MATCHES YOUR REQUIREMENTS AND THEN BIG SAD FACE
            
        #ADD GAME TO THE GAME LIBRARY
        #BROWSE ALL CURRENT GAMES
        #FINAL ADDITION I WOULD LIKE TO TRY WOULD BE TO IMPLEMENT AN API THAT WOULD SHOW THE TOP THEN HOTTEST GAMES OUT ATM,
        #BUT THIS IS THE REACH GOAL LOL 

        




