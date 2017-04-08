# Пассажирский поезд

require_relative 'train'

class PassengerTrain < Train
  def initialize(number, options = {})
    super
    @type = :passenger
  end
end
