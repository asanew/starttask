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
    raise 'Количество занятых мест не может быть больше общего' if @busy_seats == @seats
    @busy_seats += 1
  end

  def free_seats
    @seats - @busy_seats
  end

  protected
  
  def validate!
    raise "Количество место должно быть больше нуля" unless @seats > 0
    true
  end
end
