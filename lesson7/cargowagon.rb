# Товарный вагон

require_relative 'wagon'

class CargoWagon < Wagon
  
  attr_reader :volume, :busy_volume
  
  def initialize(volume)
    @type = :cargo
    @volume = volume.to_f
    @busy_volume = 0
    validate!
  end

  def fill(volume)
    volume = volume.to_f
    @busy_volume += volume
    validate!
  rescue
    @busy_volume -= volume
  end

  def free_volume
    @volume - @busy_volume
  end

  protected

  def validate!
    raise "Общий объем должен быть больше 0" unless @volume > 0
    raise "Занятый объем не может превышать общий" if @busy_volume > @volume
    true
  end
end
