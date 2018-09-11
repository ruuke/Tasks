require_relative 'brand_name'
require_relative 'instance_counter'

class Train
  TRAIN_NUMBER = /[\w]{3}-?[\w]{2}/
  @@all_trains = {}
  include BrandName
  include InstanceCounter
  attr_accessor :speed, :number
  attr_reader :type, :route, :train_wagons

  def self.find(number)
    @@all_trains[number]
  end

  def each_train(&block)
    train_wagons.each &block
  end

  def validate!
    raise 'Введите номер поезда' if number.empty?
    raise "Неверный формат номера поезда:___-__" if number !~ TRAIN_NUMBER
    true
  end

  def valid?
    validate!
  rescue
    false
  end
    
  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @train_wagons = []
    validate!
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
  end

  def add_wagon(wagon)
    @train_wagons << wagon
  end

  def remove_wagon(wagon)
    train_wagons.delete(wagon)
  end

  def drive_forward
    self.next_station
    @route.route_stations[@current_station_index].send_train(self)
    next_station.take_train(self)
    @current_station_index += 1
  end

  def drive_back
    self.previous_station
    @route.route_stations[@current_station_index].send_train(self)
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
