Usergame.destroy_all
User.destroy_all
Boardgame.destroy_all


adam = User.create(name: "Adam", username: "acnowland")
mell = User.create(name: "Mell", username: "DrZeebs")


gloomhaven = Boardgame.create(name: "Gloomhaven", duration: 120, difficulty: "Hard", ideal_number_of_players: 3)
catan = Boardgame.create(name: "Settlers of Catan", duration: 90, difficulty: "Medium", ideal_number_of_players: 4)
candyland = Boardgame.create(name: "Candyland", duration: 60, difficulty: "Easy", ideal_number_of_players: 4)


Usergame.create(user: adam, boardgame: gloomhaven)
Usergame.create(user: mell, boardgame: gloomhaven)
Usergame.create(user: mell, boardgame: catan)


