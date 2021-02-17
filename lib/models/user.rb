class User < ActiveRecord::Base 
    has_many :usergames
    has_many :boardgames, through: :usergames
end