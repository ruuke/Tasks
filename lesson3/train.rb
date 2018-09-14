require_relative 'brand_name'
require_relative 'instance_counter'

class Train
  include BrandName
  include InstanceCounter

  TRAIN_NUMBER = /[\w]{3}-?[\w]{2}/
  @@all_trains = {}

  def validate!
    raise 'Введите номер поезда' if number.empty?
    raise "Неверный формат номера поезда:___-__" if number !~ TRAIN_NUMBER

    true
  end

  attr_accessor :speed, :number
  attr_reader :type, :route, :train_wagons

  def self.find(number)
    @@all_trains[number]
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
    @route = route
    route.route_stations.first.take_train(self)
    @current_station_index = 0
  end

  def add_wagon(wagon)
    @train_wagons << wagon if speed.zero?
  end

  def remove_wagon(wagon)
    train_wagons.delete(wagon) if speed.zero?
  end

  def drive_forward
    next_station
    @route.route_stations[@current_station_index].send_train(self)
    next_station.take_train(self)
    @current_station_index += 1
  end

  def drive_back
    previous_station
    @route.route_stations[@current_station_index].send_train(self)
    previous_station.take_train(self)
    @current_station_index -= 1
  end

  def current_station
    @route.route_stations[@current_station_index]
  end

  def next_station
    route.route_stations[@current_station_index + 1] unless @route.route_stations[@current_station_index + 1].nil?
  end

  def previous_station
    route.route_stations[@current_station_index - 1] if @current_station_index > 0
  end

  def each_train(&block)
    train_wagons.each &block
  end

  def valid?
    validate!
  rescue StandardError
    false
  end
end
