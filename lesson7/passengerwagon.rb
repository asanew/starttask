# Пассажирский вагон

require_relative 'wagon'

class PassengerWagon < Wagon
  
  attr_reader :seats, :busy_seats

  def initialize(seats)
    @type = :passenger
    @seats = seats.to_i
    @busy_seats = 0
    validate!
  end
  
  def take_seat
    @busy_seats += 1
    validate!
  rescue
    @busy_seats = @seats
  end

  def free_seats
    @seats - @busy_seats
  end

  protected
  
  def validate!
    raise "Количество место должно быть больше нуля" unless @seats > 0
    raise "Количество занятых мест не может быть больще общего" if @busy_seats > @seats
    true
  end
end
