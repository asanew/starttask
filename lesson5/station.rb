# Станция

class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  def trains(type = nil)
      type ? @trains.select { |train| train.type == type } : @trains
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def self.all
    @@stations
  end
  
  protected
  @@stations = []
end

