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
    if @busy_volume + volume > @volume
      raise 'Занятый объем не может превышать общий'
    end
    @busy_volume += volume
  end

  def free_volume
    @volume - @busy_volume
  end

  protected

  def validate!
    raise 'Общий объем должен быть больше 0' unless @volume > 0
    true
  end
end
