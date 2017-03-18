# Основная программа

require_relative 'cargotrain'
require_relative 'cargowagon'
require_relative 'passengertrain'
require_relative 'passengerwagon'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'

$routes = []
$stations = []
$trains = []

def find_station(name)
  $stations.find { |station| station.name == name}
end

def error_message
  puts 'Некорректный ввод, исправьте'
end

loop do
  puts 'Введите имя раздела для работы или exit для выхода:'
  puts 'станции | поезда | маршруты'
  user_input = gets.chomp.downcase
  break if user_input == 'exit'
  case user_input
  when 'станции'
    loop do
      puts 'Введите действие или exit для выхода:'
      puts 'список | добавление | поезда'
      user_input = gets.chomp.downcase
      break if user_input == 'exit'
      case user_input
      when 'список'
        puts $stations
      when 'добавление'
        puts 'Введите имя станции'
        name = gets.chomp
        $stations << Station.new(name)
      when 'поезда'
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
      else
        error_message
      end
    end
  when 'поезда'
    loop do
      puts 'Введите действие или exit для выхода:'
      puts 'список | добавление | управление'
      user_input = gets.chomp.downcase
      break if user_input == 'exit'
      case user_input
      when 'список'
        puts $trains
      when 'добавление'
        puts 'Введите номер поезда'
        number = gets.chomp
        type = ''
        loop do
          puts 'Введите тип поезда: пассажирский или товарный'
          type = gets.chomp
          break if type == 'пассажирский' || type == 'товарный'
          error_message
        end
        $trains << ( type == 'пассажирский' ? PassengerTrain.new(number) : CargoTrain.new(number) )
      when 'управление'
        puts 'Введите номер поезда'
        number = gets.chomp
        train = $trains.find { |train| train.number == number }
        if train
          loop do
            puts 'Введите действие или exit для выхода:'
            puts '+вагон | -вагон | маршрут | вперед | назад'
            user_input = gets.chomp.downcase
            break if user_input == 'exit'
            case user_input
            when '+вагон'
              type = ""
              loop do
                puts 'Введите тип вагона: пассажирский или товарный'
                type = gets.chomp
                break if type == 'пассажирский' || type == 'товарный'
                error_message
              end
              train.add_wagon(type == 'пассажирский' ? PassengerWagon.new : CargoWagon.new)
            when '-вагон'
              puts 'Введите номер вагона'
              wagon_number = gets.chomp.to_i - 1
              if wagon_number > 0
                train.del_wagon(train.wagons[wagon_number])
              end
            when 'маршрут'
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
            when 'вперед'
              train.forward
            when 'назад'
              train.backward
            end
          end
        else
          puts 'Поезд с таким номером не найден'
        end
      else
        error_message
      end
    end
  when 'маршруты'
    loop do
      puts 'Введите действие или exit для выхода:'
      puts 'список | добавление | редактирование | назначение'
      user_input = gets.chomp.downcase
      break if user_input == 'exit'
      case user_input
      when 'список'
        puts $routes
      when 'добавление'
        puts 'Введите название начальной станции:'
        start_station = gets.chomp
        start_station = find_station(start_station)
        if start_station
          puts 'Введите название конечной станции:'
          end_station = gets.chomp
          end_station = find_station(end_station)
          if end_station
            $routes << Route.new(start_station,end_station)
          else
            puts 'Конечная станция не найдена'
          end
        else
          puts 'Начальная станция не найдена'
        end
      when 'редактирование'
        puts 'Введите номер маршрута'
        number = gets.chomp.to_i - 1
        if number >=0 && number < $routes.length
          route = $routes[number]
          loop do
            puts 'Введите действие или exit для выхода:'
            puts 'станции | добавить | удалить'
            user_input = gets.chomp.downcase
            break if user_input == 'exit'
            case user_input
            when 'станции'
              puts route.stations
            when 'добавить'
              puts 'Введите имя станции:'
              station = gets.chomp
              station = find_station(station)
              if station
                route.add_station(station)
              else
                puts 'Такой станции не существует'
              end
            when 'удалить'
              puts 'Введите имя станции:'
              station = gets.chomp
              station = find_station(station)
              if station
                route.del_station(station)
              else
                puts 'Такой станции не существует'
              end
            else
              error_message
            end
          end
        else
          puts 'Такой маршрут не существует'
        end
      when 'назначение'
        puts 'Введите номер маршрута'
        number = gets.chomp.to_i - 1
        if number >=0 && number < $routes.length
          route = $routes[number]
          puts 'Введите номер поезда'
          train = gets.chomp
          train = $trains.find { |train| train.number == train }
          if train
            train.route = route
          else
            puts 'Поезд с таким номером не найден'
          end
        else
          puts 'Такой маршрут не существует'
        end
      else
        error_message
      end
    end
  else
    error_message
  end
end
