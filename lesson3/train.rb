require_relative 'brand_name'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Train
  include BrandName
  include InstanceCounter
  include Validation
  include Accessors

  TRAIN_NUMBER = /[\w]{3}-?[\w]{2}/
  @@all_trains = {}

  attr_accessors_with_history :speed
  strong_attr_accessor :speed, Integer
  attr_reader :type, :route, :train_wagons, :number

  def self.find(number)
    @@all_trains[number]
  end

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER

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
    validate!
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
    train_wagons.each(&block)
  end
end
