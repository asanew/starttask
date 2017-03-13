# Маршрут

class Route
  attr_reader :stations
  
  def initialize(start_st,end_st)
    @stations = [start_st,end_st]
  end

  def add_station(station)
    @stations.insert(-2,station)
  end

  def del_station(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end
end

