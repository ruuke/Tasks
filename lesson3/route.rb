require_relative 'instance_counter'

class Route
  include InstanceCounter

  ERROR = 'Станция не соответствует типу данных.'.freeze

  attr_reader :route_stations

  def validate!
    raise ERROR unless @route_stations.all? { |station| station.is_a?(Station) }

    true
  end

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

  def valid?
    validate!
  rescue StandardError
    false
  end
end
