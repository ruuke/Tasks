class Station 
  attr_reader :trains  

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train unless @trains.include?(train)
  end

  def trains_type (type = :all)
    @train.select{|train| train.type == type}
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route 
  attr_reader :stations

  def initialize(first_station, last_station)
   @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station) unless self.stations.include?(station)
  end

  def remove_station(st)
    @stations.delete(st) unless [@stations.first, @stations.last].include?(st)
  end
end

class Train
  attr_accessor :speed
  attr_reader :wagons, :type, :route
    
  def initialize(num, type, wagons)
    @num = num
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagons += 1 if @speed == 0
  end

  def remove_wagon
    @wagons -= 1 if @speed == 0
  end

  def take_route(route)
    @route = route #принимает объект класса Route (маршрут)
    route.stations.first.take_train(self) #помещает поезд на первую станцию маршрута
    @current_station_index = 0
  end

  def drive_forward
    @route.stations[@current_station_index].send_train(self) if self.next_station
    next_station.take_train(self)
    @current_station_index += 1
  end

  def drive_back
    @route.stations[@current_station_index].send_train(self) if self.previous_station
    previous_station.take_train(self)
    @current_station_index -= 1
  end

  def current_station
    @route.stations[@current_station_index]
  end


  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index != -1
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end
end

=begin
st1 = Station.new("Ufa")
st2 = Station.new("Msk")
st3 = Station.new("Spb")
r1 = Route.new(st1, st3)
r1.add_station(st2)
tr1 = Train.new(111, "cargo", 8)
tr1.take_route(r1)
tr1.current_station
tr1.next_station
tr1.previous_station
puts
tr1.drive_forward
tr1.current_station
tr1.next_station
tr1.previous_station
puts
tr1.drive_forward
tr1.current_station
tr1.next_station
tr1.previous_station
puts
tr1.drive_back
tr1.current_station
tr1.next_station
tr1.previous_station
puts
tr1.drive_back
tr1.current_station
tr1.next_station
tr1.previous_station
=end
