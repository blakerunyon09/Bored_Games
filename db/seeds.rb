Usergame.destroy_all
User.destroy_all
Boardgame.destroy_all


adam = User.create(name: "Adam", username: "acnowland")
mell = User.create(name: "Mell", username: "DrZeebs")


gloomhaven = Boardgame.create(name: "Gloomhaven", duration: 120, difficulty: "Hard", ideal_number_of_players: 3)
catan = Boardgame.create(name: "Settlers of Catan", duration: 90, difficulty: "Medium", ideal_number_of_players: 4)
candyland = Boardgame.create(name: "Candyland", duration: 60, difficulty: "Easy", ideal_number_of_players: 4)
galaxy_trucker = Boardgame.create(name: "Galaxy Trucker", duration: 90, difficulty: "Medium", ideal_number_of_players: 4)
terraforming = Boardgame.create(name: "Terraforming Mars", duration: 120, difficulty: "Medium", ideal_number_of_players: 3)
pandemic = Boardgame.create(name: "Pandemic: Legacy", duration: 120, difficulty: "Easy", ideal_number_of_players: 2)
twilight = Boardgame.create(name: "Twilight Emperium", duration: 240, difficulty: "Hard", ideal_number_of_players: 6)
star_wars = Boardgame.create(name: "Star Wars: Rebellion", duration: 120, difficulty: "Medium", ideal_number_of_players: 2)
Boardgame.create(name: "Twilight Struggle", duration: 120, difficulty: "Hard", ideal_number_of_players: 2)
Boardgame.create(name: "Cosmic Encounter", duration: 90, difficulty: "Easy", ideal_number_of_players: 5)
Boardgame.create(name: "Terra Mystica", duration: 120, difficulty: "Medium", ideal_number_of_players: 4)
Boardgame.create(name: "Coup", duration: 30, difficulty: "Easy", ideal_number_of_players: 5)
Boardgame.create(name: "Splendor", duration: 30, difficulty: "Easy", ideal_number_of_players: 3)
Boardgame.create(name: "Cartographers", duration: 30, difficulty: "Easy", ideal_number_of_players: 2)
Boardgame.create(name: "Azul", duration: 60, difficulty: "Medium", ideal_number_of_players: 4)

Usergame.create(user: adam, boardgame: gloomhaven)
Usergame.create(user: mell, boardgame: gloomhaven)
Usergame.create(user: mell, boardgame: catan)


