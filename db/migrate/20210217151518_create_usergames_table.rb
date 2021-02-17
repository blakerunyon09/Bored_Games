class CreateUsergamesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :usergames do |t|
      t.references :user
      t.references :boardgame 
    end
  end
end
