require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'railroad'
require_relative 'wagons'
require_relative 'CargoTrain'
require_relative 'PassengerTrain'
require_relative 'CargoWagon'
require_relative 'PassengerWagon'

puts "Давай создадим железную дорогу."
@rr = RailRoad.new

@rr.seed


