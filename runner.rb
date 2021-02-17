require_relative 'config/environment'
ActiveRecord::Base.logger = nil
app = Cli.new
app.start



binding.pry



