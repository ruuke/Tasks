class Train
  
  attr_accessor :speed
  attr_reader :type, :route, :train_wagons, :trains, :number
    
  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @train_wagons = []
  end

  def stop
    @speed = 0
  end

  def take_route(route)
    @route = route #принимает объект класса Route (маршрут)
    route.route_stations.first.take_train(self) #помещает поезд на первую станцию маршрута
    @current_station_index = 0
  end

  def add_wagon(wagon)
    @train_wagons << wagon if @speed == 0 && wagon.type == type unless train_wagons.include?(wagon)
  end

  def remove_wagon(wagon) 
    train_wagons.delete(wagon) if @speed == 0 && train_wagons.include?(wagon)
  end

  def drive_forward
    @route.route_stations[@current_station_index].send_train(self) if self.next_station
    next_station.take_train(self)
    @current_station_index += 1
  end

  def drive_back
    @route.route_stations[@current_station_index].send_train(self) if self.previous_station
    previous_station.take_train(self)
    @current_station_index -= 1
  end

  def current_station
    @route.route_stations[@current_station_index]
  end


  def next_station
    route.route_stations[@current_station_index + 1] if @route.route_stations[@current_station_index + 1] != nil
  end

  def previous_station
    route.route_stations[@current_station_index - 1] if @current_station_index > 0
  end
end
