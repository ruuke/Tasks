class CargoWagon < Wagon
  attr_reader :taken_volume, :free_volume

  def initialize(total_volume, type = :cargo)
    super
    @total_volume = total_volume
    @taken_volume = 0
    @free_volume = @total_volume - @taken_volume
  end

  def take_volume(volume)
    @taken_volume += volume if @free_volume >= volume
    @free_volume -= volume if @free_volume >= volume
  end
end
