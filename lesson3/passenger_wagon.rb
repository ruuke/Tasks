class PassengerWagon < Wagon
	attr_reader :taken_seats, :free_seats
  def initialize(type = :passenger, total_number_of_seats)
    super
    @total_number_of_seats = total_number_of_seats
    @taken_seats = 0
    @free_seats = @total_number_of_seats - @taken_seats
  end

  def take_a_seat
  	@taken_seats += 1 if @free_seats != 0
  	@free_seats -= 1 if @free_seats != 0
  end
end
