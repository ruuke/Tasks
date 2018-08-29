class Route 
  attr_reader :route_stations, :name

  def initialize(first_station, last_station)
   @route_stations = [first_station, last_station]
  end

  def add_station(station)
    @route_stations.insert(-2, station) unless self.route_stations.include?(station)
  end

  def remove_station(station)
    @route_stations.delete(station) unless [@route_stations.first, @route_stations.last].include?(station)
  end
end