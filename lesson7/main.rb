# Основная программа

require_relative 'cargotrain'
require_relative 'cargowagon'
require_relative 'passengertrain'
require_relative 'passengerwagon'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'

class Program
  attr_reader :routes
  
  def initialize
    @routes = []
  end

  def menu
    loop do
      puts 'Введите имя раздела для работы или exit для выхода:'
      puts 'станции | поезда | маршруты'
      user_input = gets.chomp.downcase
      break if user_input == 'exit'
      case user_input
      when 'станции'
        stations_menu
      when 'поезда'
        trains_menu
      when 'маршруты'
        routes_menu
      else
        error_message
      end
    end
  end
  
  private

  def error_message
    puts 'Некорректный ввод, исправьте'
  end

  def find_station(name)
    Station.all.find { |station| station.name == name}
  end

  def stations_list
    puts Station.all
  end

  def add_station
    puts 'Введите имя станции'
    name = gets.chomp
    Station.new(name)
  end

  def station_trains
    puts 'Введите имя станции'
    name = gets.chomp
    station = find_station(name)
    if station
      puts 'Введите тип поезда: пассажирский | товарный | любой'
      type = gets.chomp
      case type
      when 'пассажирский'
        type = :passenger
      when 'товарный'
        type = :cargo
      else
        type = nil
      end
      puts station.trains(type)
    else
      puts 'Такая станция не найдена'
    end
  end

  def stations_menu
    loop do
      puts 'Введите действие или exit для выхода:'
      puts 'список | добавление | поезда'
      user_input = gets.chomp.downcase
      break if user_input == 'exit'
      case user_input
      when 'список'
        stations_list
      when 'добавление'
        add_station
      when 'поезда'
        station_trains
      else
        error_message
      end
    end
  end

  def trains_list
    Train.all
  end
  
  def add_train
    puts 'Введите номер поезда'
    number = gets.chomp
    type = ''
    loop do
      puts 'Введите тип поезда: пассажирский или товарный'
      type = gets.chomp
      break if type == 'пассажирский' || type == 'товарный'
      error_message
    end
    type == 'пассажирский' ? PassengerTrain.new(number) : CargoTrain.new(number)
  end

  def add_wagon(train)
    type = ""
    loop do
      puts 'Введите тип вагона: пассажирский или товарный'
      type = gets.chomp
      break if type == 'пассажирский' || type == 'товарный'
      error_message
    end
    if type == 'пассажирский'
      puts 'Введите количество мест'
      seats = gets.chomp
      train.add_wagon(PassengerWagon.new(seats))
    else
      puts 'Введите объем вагона'
      volume = gets.chomp
      train.add_wagon(CargoWagon.new(volume))
    else
  end

  def del_wagon(train)
    puts 'Введите номер вагона'
    wagon_number = gets.chomp.to_i - 1
    if wagon_number > 0
      train.del_wagon(train.wagons[wagon_number])
    end
  end

  def train_route(train)
    loop do
      puts 'Выберите станцию для просмотра или exit для выхода:'
      puts 'предыдушая | текущая | следующая'
      type = gets.chomp
      break if type == 'exit'
      case type
      when 'предыдущая'
        puts train.prev_station
      when 'текущая'
        puts train.current_station
      when 'следующая'
        puts train.next_station
      else
        error_message
      end
    end
  end

  def manage_train
    puts 'Введите номер поезда'
    number = gets.chomp
    train = Train.find(number)
    if train
      loop do
        puts 'Введите действие или exit для выхода:'
        puts '+вагон | -вагон | маршрут | вперед | назад'
        user_input = gets.chomp.downcase
        break if user_input == 'exit'
        case user_input
        when '+вагон'
          add_wagon(train)
        when '-вагон'
          del_wagon(train)
        when 'маршрут'
          train_route(train)
        when 'вперед'
          train.forward
        when 'назад'
          train.backward
        end
      end
    else
      puts 'Поезд с таким номером не найден'
    end
  end

  def trains_menu
    loop do
      puts 'Введите действие или exit для выхода:'
      puts 'список | добавление | управление'
      user_input = gets.chomp.downcase
      break if user_input == 'exit'
      case user_input
      when 'список'
        trains_list
      when 'добавление'
        add_train
      when 'управление'
        manage_train
      else
        error_message
      end
    end
  end

  def routes_list
    puts @routes
  end

  def add_route
    puts 'Введите название начальной станции:'
    start_station = gets.chomp
    start_station = find_station(start_station)
    if start_station
      puts 'Введите название конечной станции:'
      end_station = gets.chomp
      end_station = find_station(end_station)
      if end_station
        @routes << Route.new(start_station,end_station)
      else
        puts 'Конечная станция не найдена'
      end
    else
      puts 'Начальная станция не найдена'
    end
  end

  def route_stations_list(route)
    puts route.stations
  end
 
  def route_add_station(route)
    puts 'Введите имя станции:'
    station = gets.chomp
    station = find_station(station)
    if station
      route.add_station(station)
    else
      puts 'Такой станции не существует'
    end
  end

  def route_del_station(route)
    puts 'Введите имя станции:'
    station = gets.chomp
    station = find_station(station)
    if station
      route.del_station(station)
    else
      puts 'Такой станции не существует'
    end
  end

  def edit_route
    puts 'Введите номер маршрута'
    number = gets.chomp.to_i - 1
    if number >=0 && number < @routes.length
      route = @routes[number]
      loop do
        puts 'Введите действие или exit для выхода:'
        puts 'станции | добавить | удалить'
        user_input = gets.chomp.downcase
        break if user_input == 'exit'
        case user_input
        when 'станции'
          route_stations_list(route)
        when 'добавить'
          route_add_station(route)
        when 'удалить'
          route_del_station(route)
        else
          error_message
        end
      end
    else
      puts 'Такой маршрут не существует'
    end
  end
  
  def assign_route
    puts 'Введите номер маршрута'
    number = gets.chomp.to_i - 1
    if number >=0 && number < @routes.length
      route = @routes[number]
      puts 'Введите номер поезда'
      train = gets.chomp
      train = Train.find(train)
      if train
        train.route = route
      else
        puts 'Поезд с таким номером не найден'
      end
    else
      puts 'Такой маршрут не существует'
    end
  end

  def routes_menu
    loop do
      puts 'Введите действие или exit для выхода:'
      puts 'список | добавление | редактирование | назначение'
      user_input = gets.chomp.downcase
      break if user_input == 'exit'
      case user_input
      when 'список'
        routes_list
      when 'добавление'
        add_route
      when 'редактирование'
        edit_route
      when 'назначение'
        assign_route
      else
        error_message
      end
    end
  end
end

program = Program.new
program.menu
