class CreateBoardgamesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :boardgames do |t|
      t.string :name
      t.integer :duration
      t.string :difficulty
      t.integer :ideal_number_of_players
    end
  end
end
