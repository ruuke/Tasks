require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'railroad'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

puts "Давай создадим железную дорогу."
@rr = RailRoad.new
#@rr.seed
@rr.main_menu
