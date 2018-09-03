require_relative 'instance_counter'

class Route 
  include InstanceCounter
  attr_reader :route_stations, :name

  def initialize(first_station, last_station)
    @route_stations = [first_station, last_station]
    register_instances
  end

  def add_station(station)
    if route_stations.include?(station)
      puts "Станция #{station.name} есть в списке маршрута."
    else
      @route_stations.insert(-2, station)
      puts "Станция #{station.name} добавлена в маршрут."
    end
  end

  def remove_station(station)
    if [@route_stations.first, @route_stations.last].include?(station)
      puts "Начальную и конечную станцию маршрута нельзя удалить."
    elsif !route_stations.include?(station)
      puts "Данной станции нет в списке маршрута."
    else
      @route_stations.delete(station)
      puts "Станция #{station.name} удалена из маршрута."
    end
  end
end