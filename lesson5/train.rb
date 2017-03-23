# Поезда

require_relative 'manufacter'
require_relative 'instancecounter'

class Train
  attr_reader :number, :type, :wagons, :speed
  attr_accessor :route

  include Manufacter
  # не указано куда подключать, поэтому для примера в Train
  include InstanceCounter

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @route_station = 0
    @@trains << self
    register_instance
  end
  
  def accelerate(value)
    @speed += value if value > 0
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if !move? && wagon.type == @type
  end

  def del_wagon(wagon)
    @wagons.delete(wagon) unless move?
  end

  def forward
    move unless last_station?
  end

  def backward
    move(false) unless first_station?
  end

  def current_station
    @route.stations[@route_station]
  end

  def next_station
    @route.stations[@route_station + 1]
  end

  def prev_station
    @route.stations[@route_station - 1] unless first_station?
  end

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def self.all
    @@trains
  end

  protected

  @@trains = [] 

  # Проверка по условию нужна только для метода добавления/удаления вагонов
  def move?
    @speed > 0
  end

  # Про эти методы вообще ничего в условиях не сказано, знать про них пользователю не нужно
  def first_station?
    @route_station == 0
  end

  def last_station?
    @route_station == @route.stations.count - 1
  end

  # Метод создан для устранения дублирования кода в методах перемещения поезда, чистой воды сокрытие реализации
  def move(forward = true)
    @route.stations[@route_station].send_train
    @route_station += forward ? 1 : -1
    @route.stations[@route_station].take_train
  end
end

