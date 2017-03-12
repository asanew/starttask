# Поезда

class Train

  attr_reader :number, :type, :wagons, :speed
  attr_accessor :route

  def initialize(number, type = :passenger, wagons = 0)
    @number = number
    @type = type == :passenger ? :passenger : :cargo
    @wagons = wagons
    @speed = 0
    @route_station = 0
  end

  def speed=(speed)
    @speed = speed <= 0 ? 0 : speed
  end

  def add_wagon
    @wagons += 1 if @speed == 0
  end

  def del_wagon
    @wagons -= 1 if @speed == 0 && @wagons > 0
  end

  def move(forward = true)
    @route_station += 1 if forward && @route_station < @route.stations - 1
    @route_station -= 1 if !forward && @route_station > 0
  end

  def route_info
    puts @route.stations[@route_station - 1] if @route_station > 0
    puts @route.stations[@route_station]
    puts @route.stations[@route_station + 1] if @route_station < @route.stations.count - 1
  end

end
