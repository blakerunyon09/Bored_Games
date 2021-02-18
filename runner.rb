require_relative 'config/environment'
ActiveRecord::Base.logger = nil
app = Cli.new
system('clear')
app.start




