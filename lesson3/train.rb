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

  def move?
    @speed > 0
  end
  
  def accelerate(value)
    @speed += value if value > 0
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagons += 1 unless move?
  end

  def del_wagon
    @wagons -= 1 unless move? && @wagons > 0
  end

  def move(forward = true)
    @route.stations[@route_station].send_train
    @route_station += forward ? 1 : -1
    @route.stations[@route_station].take_train
  end

  def forward
    self.move unless self.last_station
  end

  def backward
    self.move(false) unless self.first_station
  end

  def first_station?
    @route_station == 0
  end

  def last_station?
    @route_station == @route.stations.count - 1
  end
  
  def current_station
    @route.stations[@route_station]
  end

  def next_station
    @route.stations[@route_station + 1]
  end

  def prev_station
    @route.stations[@route_station - 1] unless self.first_station?
  end
end

