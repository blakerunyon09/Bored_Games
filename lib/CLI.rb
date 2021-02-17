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
        binding.pry
    end


    def sign_in 
        user_input = prompt.ask "What is your username?"
        found_user = User.find_by(username: user_input)
        if found_user
            self.user = found_user 
        else
            puts "So Sorry Bud, that username doesn't exist. Let's sign you up!"
            sign_up
        end
    end

    def sign_up
        name = prompt.ask "What's your name?"
        username = prompt.ask "What's your username?"

        self.user = User.create(
            name: name,
            username: username)

        puts "Thanks! Let's go to the main menu!"
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

        




