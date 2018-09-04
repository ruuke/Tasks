require_relative 'brand_name'
require_relative 'instance_counter'

class Train
  @@all_trains = {}
  include BrandName
  include InstanceCounter
  attr_accessor :speed
  attr_reader :type, :route, :train_wagons, :number

  def self.find(number)
    @@all_trains[number]
  end

    
  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @train_wagons = []
    @@all_trains[number] = self
    register_instances
  end

  def stop
    @speed = 0
  end

  def take_route(route)
    @route = route #принимает объект класса Route (маршрут)
    route.route_stations.first.take_train(self) #помещает поезд на первую станцию маршрута
    @current_station_index = 0
    puts "Поезд помещен на станцию #{current_station.name}"
  end

  def add_wagon(wagon)
    if wagon == nil
      puts "Данного вагона не сущесвует"
    elsif wagon.type != type
      puts "Неверно выбран тип вагона"
    elsif train_wagons.include?(wagon)
      puts "Данный вагон уже прицеплен"
    elsif @speed == 0 && wagon.type == type 
      @train_wagons << wagon
      puts "Вагон прицеплен."
    end
  end

  def remove_wagon(wagon)
    if !train_wagons.include?(wagon)
      puts "Такой вагон не приценлен к поезду."
    elsif @speed == 0 && train_wagons.include?(wagon)
      train_wagons.delete(wagon)
      puts "Вагон отцеплен."
    end
  end

  def drive_forward
    if next_station == nil
      puts "Станция #{current_station.name} конечная."
    elsif self.next_station
      @route.route_stations[@current_station_index].send_train(self)
      next_station.take_train(self)
      @current_station_index += 1
      puts "Поезд помещен на станцию #{current_station.name}."
    end
  end

  def drive_back
    if previous_station == nil
      puts "Станция #{current_station.name} начальная."
    elsif self.previous_station
      @route.route_stations[@current_station_index].send_train(self)
      previous_station.take_train(self)
      @current_station_index -= 1
      puts "Поезд помещен на станцию #{current_station.name}."
    end
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
