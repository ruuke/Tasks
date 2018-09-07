require_relative 'instance_counter'

class Station 
  LETTERS = /[a-z]/i
  @@all_stations = []
  include InstanceCounter
  attr_reader :trains
  attr_accessor :name

  def self.all
    @@all_stations
  end

  def validate!
    raise "Введите название станции." if name.empty?
    raise "Введите название станции in English." if name !~ LETTERS
    true
  end

  def initialize(name)
    @name = name
    @trains = [] 
    validate!
    @@all_stations << self  
    register_instances
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

  def valid?
    validate!
  rescue
    false
  end
end