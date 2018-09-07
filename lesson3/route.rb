require_relative 'instance_counter'

class Route 
  include InstanceCounter
  attr_reader :route_stations, :name

  def initialize(first_station, last_station)
    @route_stations = [first_station, last_station]
    register_instances
  end

  def add_station(station)
    @route_stations.insert(-2, station)
  end

  def remove_station(station)
     @route_stations.delete(station)
  end
end