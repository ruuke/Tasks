require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :route_stations

  def initialize(first_station, last_station)
    @route_stations = [first_station, last_station]
    validate!
    register_instances
  end

  validate :route_stations, :type, Station

  def add_station(station)
    @route_stations.insert(-2, station)
    validate!
  end

  def remove_station(station)
    @route_stations.delete(station)
    validate!
  end
end
