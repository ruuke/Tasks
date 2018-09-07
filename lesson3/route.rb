require_relative 'instance_counter'

class Route 
  include InstanceCounter
  attr_reader :route_stations, :name

  def initialize(first_station, last_station)
    @route_stations = [first_station, last_station]
    validate!
    register_instances
  end

  def add_station(station)
    @route_stations.insert(-2, station)
    validate!
  end

  def remove_station(station)
     @route_stations.delete(station)
     validate!
  end

  def validate!
    raise 'Станция не соответствует типу данных.' if !@route_stations.each {|station| station.is_a?(Station)}
    true
  end

  def valid?
    validate!
  rescue
    false
  end
end