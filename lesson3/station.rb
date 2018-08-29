class Station 
  attr_reader :trains, :name
  
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