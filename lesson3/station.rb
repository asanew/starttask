# Станция

class Station
  def initialize(name)
    @name = name
    @trains = []
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
end

