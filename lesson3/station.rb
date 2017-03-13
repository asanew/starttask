# Станция

class Station
  def initialize(name)
    @name = name
    @trains = []
  end

  def trains(type = nil)
    if @trains.any?
      if !type
        @trains
      else
        @trains.select { |train| train.type == type }
      end
    else
     nil 
    end
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end
end

