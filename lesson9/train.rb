# Поезда

require_relative 'manufacter'
require_relative 'instancecounter'
require_relative 'route'
require_relative 'validation'

class Train
  include Validation
  include Manufacter
  include InstanceCounter
  
  attr_reader :number, :type, :wagons, :speed, :route

  validate :number, :format, /^[\d\wа-я]{3}[-]{0,1}[\d\wа-я]{2}$/i
  validate :route, :type, Route

  def initialize(number, options = {})
    @number = number
    validate!
    @wagons = options[:wagons] || []
    @route = options[:route]
    @speed = 0
    @route_station = 0
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def self.all
    @@trains.values
  end

  def each_wagon
    if block_given?
      @wagons.each { |wagon| yield wagon }
    else
      @wagons.each
    end
  end

  def each_wagon_with_number
    if block_given?
      @wagons.each_with_index(1) { |wagon, index| yield wagon, index }
    else
      @wagons.each
    end
  end

  def route=(route)
    raise 'Назначаемый маршрут должен быть объектом класса Route' unless
      route.class == Route
    @route = route
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

  @@trains ||= {}

  protected

  # Проверка по условию нужна только для метода добавления/удаления вагонов
  def move?
    @speed > 0
  end

  # Про эти методы вообще ничего в условиях не сказано,
  # знать про них пользователю не нужно
  def first_station?
    @route_station.zero?
  end

  def last_station?
    @route_station == @route.stations.count - 1
  end

  # Метод создан для устранения дублирования кода в методах перемещения
  # поезда, чистой воды сокрытие реализации
  def move(forward = true)
    @route.stations[@route_station].send_train
    @route_station += forward ? 1 : -1
    @route.stations[@route_station].take_train
  end
end
