# Основная программа

require_relative 'cargotrain'
require_relative 'cargowagon'
require_relative 'passengertrain'
require_relative 'passengerwagon'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'

routes = []
stations = []
trains = []

def find_station(name)
  stations.find { |station| station.name == name}
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
      case user_input
      when 'список'
        puts stations
      when 'добавление'
        puts 'Введите имя станции'
        name = gets.chomp
        stations << Station.new(name)
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
  when 'маршруты'
  else
    error_message
  end

end
