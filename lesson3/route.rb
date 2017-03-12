# Маршрут

require_relative 'listoperations'

class Route

  include ListOperations
  
  attr_reader :stations
  
  def initialize(start_st,end_st)
    @stations = [start_st,end_st]
  end

  def add_station(station)
    end_st = @stations.pop
    list_add(@stations,station)
    list_add(@stations,end_st)
  end

  def del_station(station)
    if station != @stations.first && station != @stations.last
      list_del(@stations,station)
    end
  end
  
  def print
    puts @stations
  end

end

