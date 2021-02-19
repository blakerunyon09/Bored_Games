
class Cli  

    attr_accessor :user

    def initialize user=nil
        @user = user 
    end

    def prompt 
        TTY::Prompt.new
    end


    #MAIN STARTUP SCREEN --> OFFERS LOGIN AND IF NO USERNAME WILL GIVE YOU SIGN UP OPTION 
    def start 
        
        system('clear')
        pid = fork{exec 'afplay', "lib/Tron_sounds2.mp3"}
        Artwork.title
        user_input = prompt.yes? "Have you been here before?"
        if user_input
            sign_in
        else
            sign_up
        end
    end

    def Tron_sound 
        pid = fork{exec 'afplay', "lib/Tron_sounds2.mp3"}
    end



    #SIGN IN METHOD --> WILL SET YOUR USERNAME TO THE CURRENT SELF.USER, IF USER NON-EXISTENT USER WILL SIGN YOU UP
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
    #SIGN UP METHOD --> CREATES A NEW USER, WILL NOT ALLOW OVERLAP OF USERNAMES, SETS NEW USER TO SELF.USER
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
    #MAIN MENU --> GIVES OPTIONS FOR QUIZ, RANDOM GAME, ADD A GAME, VIEW CATALOGUE OF GAMES, SEE FAVES, OR EXIT
    def main_menu
        
        system("clear")
        Artwork.bored_game
        all_selection = ["Lets find your perfect match, bud", "Lets find you a rando game, bud", "Add a game to the catalogue, bud", "Lets see ALL the games, bud", "See all your favorite games, bud", "Exit!"]
        main_selection = prompt.select("Welcome to the main menu #{user.name}, what would you like to do bud?", all_selection)
        case main_selection
        #QUIZ SECTION
        when "Lets find your perfect match, bud"
            find_your_best_board_bud
            return_or_exit
            system('clear')
        #RANDOM GAME SECTION
        when "Lets find you a rando game, bud"
            pastel = Pastel.new()
            
            rando_game = Boardgame.all.sample
            Artwork.progress_bar
            puts "#{pastel.cyan.bold(rando_game.name)} is a #{pastel.bright_green.bold(rando_game.difficulty)} difficulty game to learn and play. It plays best with #{pastel.bright_green.bold(rando_game.ideal_number_of_players)} buds and will take you about #{pastel.bright_green.bold(rando_game.duration)} minutes to play!"
            add_to_fave = prompt.yes?("Would you like to add this to your favorite games?")
            if find_all_favorites.include?(rando_game.name)
                puts 'Thats already part of your favorites list bud!!'
                return_or_exit
            end
            
            if add_to_fave
                Usergame.create(user: @user, boardgame: rando_game)
            end
            return_or_exit
        
        #ALLOWS ADDITION OF A GAME; WILL NOT TAKE MULTIPLES, CHECKS THE DB FIRST 
        when "Add a game to the catalogue, bud"
            puts "Bud, you are doing some good work, lets enter a new boardgame so other buds can access it as well"
            bg_name = prompt.ask("What is the name of the boardgame?")
            bg_players = prompt.ask("What is the ideal number of players?", convert: :integer)
            bg_difficulty = prompt.select("How hard is this game to learn and play?",["Easy", "Medium", "Hard"])
            bg_duration = prompt.ask("About how long does a game usually last (in minutes)?", convert: :integer)
            ##NEED TO MAKE A CHECK TO SEE IF GAME ALREADY EXISTS
            
            if Boardgame.find_by(name: bg_name)
                puts "Hey bud, that game already exists!!"
                puts "Lets try something else..."
                return_or_exit
            else
                Boardgame.create(name: bg_name, duration: bg_duration, difficulty: bg_difficulty, ideal_number_of_players: bg_players)
                puts "Thats awesome!! Your game has now been added so all the other buds can see it too! \n"

            end
            return_or_exit
        #VIEW ALL GAME CATALOGUE
        when "Lets see ALL the games, bud"  
            Boardgame.all.each do |game|
                puts game.name
            end
            return_or_exit
        #VIEW FAVORITE GAMES WHICH HAVE BEEN SAVED
        when "See all your favorite games, bud"
            your_favorites = find_all_favorites
            if your_favorites.length > 0
                your_favorites.each do |game|
                    puts game
                end
            else
                puts "You don't have any favorite games bud!!!!"
            end

            return_or_exit
        when "Exit!"
            system('clear')
            Artwork.goodbye
            puts "Thanks for stopping by buddy!"
            exit!
            
        end

    end

    #FILTERS THROUGH USERGAME DB AND THEN WILL RETURN A LIST OF FAVORITES FOR THAT USER
    def find_all_favorites
        all_faves = Usergame.all.filter do |user_fav|
            user_fav.user == @user
        end
        named_faves = all_faves.map do |favorite|
            favorite.boardgame.name
        end

    end
    #OPTION AFTER GOING TRHOUGH MENU TO RETURN TO MENU OR EXIT APP
    def return_or_exit
        what_to_do = prompt.select("What would you like to do now, bud?",["Return to the main menu", "Exit"])
        if what_to_do == "Return to the main menu"
            system('clear')
            main_menu
        else
            system('clear')
            Artwork.goodbye
            puts "Thanks for stopping by buddy!"
            exit!
        end
    end
    #QUIZ METHOD TO FIND A GOOD OPTION FOR YOUR PLAY GROUP, GOES THROUGH QUESTIONS AND THEN FILTERS A LIST OF BOARDGAMES DOWN TO LIST MATCHING CRITERIA
    def find_your_best_board_bud
        pastel = Pastel.new()
        board_games = Boardgame.all 
        question_1 = prompt.select("How many buds in your inner circle?",[2,3,4,"I have more than four buds."])
        if question_1 == "I have more than four buds."
            question_1 = 5
            board_games = board_games.filter do |game|
                game.ideal_number_of_players >= question_1
            end
        else
            board_games = board_games.filter do |game|
                game.ideal_number_of_players == question_1
            end
            
        end
        
        question_2 = prompt.select("How motivated are you?",{"I barely got out of bed.": "Easy","I might do a quick workout.": "Medium","I am CRUSHING this day!": "Hard"})
        board_games = board_games.filter do |game|
            game.difficulty == question_2
        end
        

        question_3 = prompt.select("How much time do you have to kill?",{"Enough for a quickie.": 60,"Just killing some time.": 90,"Got all day baby!": 240})
        board_games = board_games.filter do |game|
            game.duration <= question_3
        end 
        

        
        board_games = board_games.sample
        Artwork.progress_bar
        if board_games
            puts "#{pastel.cyan.bold(board_games.name)} is a #{pastel.bright_green.bold(board_games.difficulty)} difficulty game to learn and play. It plays best with #{pastel.bright_green.bold(board_games.ideal_number_of_players)} buds and will take you about #{pastel.bright_green.bold(board_games.duration)} minutes to play!"
        else
            puts "Sorry there bud, we have no matches at this time :("
        end
    end


end









