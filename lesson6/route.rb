# Маршрут

require_relative 'station'

class Route
  attr_reader :stations
  
  def initialize(start_station,end_station)
    @stations = [start_station,end_station]
    validate!
  end

  def add_station(station)
    raise "Добавляемая станция должна быть объектом класса Station" unless station.class == Station
    @stations.insert(-2,station)
  end

  def del_station(station)
    raise "Нельзя удалить первую и последнюю станции из маршрута" if station == @stations.first || station == @stations.last
    @stations.delete(station)
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Станции маршрута должны быть объектами класса Station" if @stations.any? { |station| station.class != Station }
    true
  end
end

