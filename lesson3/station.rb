require_relative 'instance_counter'

class Station 
  @@all_stations = []
  include InstanceCounter
  attr_reader :trains, :name

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = [] 
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
end