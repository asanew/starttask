# Станция

require_relative 'listoperations'

class Station

  include ListOperations

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains(type = nil)
    if @trains.any?
      if !type
        puts "Список всех поездов на станции:"
        puts @trains
      else
        puts "Список #{type == :passenger ? 'пассажирских' : 'грузовых'} поездов на станции"
        puts @trains.select { |train| train.type == type }
      end
    else
      puts "На станции нет поездов"
    end
  end

  def take_train(train)
    list_add(@trains,train)
  end

  def send_train(train)
    list_del(@trains,train)
  end

end

