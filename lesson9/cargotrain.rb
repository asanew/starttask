# Товарный поезд

require_relative 'train'

class CargoTrain < Train
  def initialize(number, options = {})
    super
    @type = :cargo
  end
end
