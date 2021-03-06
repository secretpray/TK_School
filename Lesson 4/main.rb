require_relative "station"
require_relative "route"
require_relative "train"
require_relative "train_cargo"
require_relative "train_passenger"
require_relative "wagon"
require_relative "wagon_cargo"
require_relative "wagon_passenger"
#require_relative "ss"
 

class Main

  def initialize
  @stations =   []
  @routes   =   []
  @trains   =   []

  end
  
  def show_stations_list
    @stations.each_with_index { |station, index| puts "#{index.next}. #{station}" }
  end

  def show_stations_list_route
    @stations.each { |station| puts "#{station}" }
  end

  def show_trains_list
    @trains.each { |train| puts "Поезд номер: #{train.number}, тип #{train.type}, в составе которого #{train.wagons.size} вагонов(а)" }
  end

    def show_trains_list_number
    @trains.each_with_index { |train, index| puts "#{index.next}. Поезд номер: #{train.number}, тип #{train.type}, в составе которого #{train.wagons.size} вагонов(а)" }
  end

  def show_routes_list
    @routes.each_with_index { |route, index| puts "#{index.next}. #{route}" }
    # @routes.each { |route| puts "#{route.list_stations}" }
  end

  def show_station_info
    show_stations_list
    puts 'Выберите станцию:'
    station = @stations[gets.chomp.to_i - 1]
    if station.trains.empty?
      puts "На станции #{station} нет поездов"
    else
      puts "Сейчас на станции #{station} следующие поезда (#{station.trains.size}):\n" \
           "#{station.current_trains.join("\n")}"
    end
  end

  def clear_screen
    print "\e[2J\e[f"
  end

  def start
    system 'clear'
    loop do
      
      help_main

      case gets.chomp.to_i
      when 0
        break
      when 1 
      	create_object
      when 2 
      	change_object
      when 3 
      	info_object
      else
        puts 'Неизвестная команда!'
      end
    end
  end

  def help_main
    puts '*****' * 17
    puts '*                   Главное меню "Управления железной дорогой.                       *'
    puts '*****' * 17
    puts 
    puts 'Выберите желаемое действие. Некоторые функции станут доступны после создания обьектов!'
    puts 'Введите 1 => для создания поезда, станции, маршрута;'
    puts 'Введите 2 => для изменение маршрута, состава поездов и их перемещения;' unless @trains.empty? && @routes.empty?
    puts 'Введите 3 => для получения информации о поездах, маршрутах и станциях;'
    puts
    puts 'Для выхода из программы нажмите Enter или 0...'
  end


  def create_object
    clear_screen  # system 'clear'
	  puts 'Создаем обьекты'
	  loop do
      
      help_create

      case gets.chomp.to_i
      when 0
        break
      when 1 
      	system 'clear'
      	puts 'Создаем поезд...'
      	print "Введите номер нового поезда: "
        number = gets.chomp.to_i

        puts "Введите тип поезда:\n 1. Пассажирский,\n 2. Грузовой"
        type = gets.chomp.to_i

        puts "Введите количество вагонов:"
        wagons_count = gets.chomp.to_i
        wagons = []
        if type == 1 
          wagons_count.times { wagons << CargoWagon.new} 
        elsif type == 2
          wagons_count.times { wagons << PassengerWagon.new}
        else
          puts "Неверный тип поезда"
        end

        if type == 1 
          @trains << CargoTrain.new(number, wagons) 
        else
          @trains << PassengerTrain.new(number, wagons)
        end
        # puts "#{@trains.last} создан."
        puts 'Создан(ы):'
        show_trains_list
        puts "\n"
        sleep(0.3)
      when 2 
      	system 'clear'
      	puts 'Создаем станцию...'
   		  print "Введите название для новой станции: "
    	  @stations << Station.new(gets.chomp.to_s) # + Add route & Info train on station
        puts "Станция #{@stations.last} создана"
        puts 'Список всех станций:'
        show_stations_list 
    	  puts "\n\n"
        sleep(0.3)
      when 3 
      	system 'clear'
      	puts 'Создаем маршрут...'
        show_stations_list
        puts  'Ввберите номер начальной станции...'
      	departure_station = @stations[gets.chomp.to_i - 1]
      	puts  'Выберите номер конечной станции...'
        destination_station = @stations[gets.chomp.to_i - 1]
		    @routes << Route.new(departure_station, destination_station)
        puts "Маршрут #{@routes.last} создан."
        puts 'Создан(ы):'
        show_routes_list  
		    puts "\n"
        sleep(0.3)
      else
        puts 'Неизвестная команда!'
      end
    end
  end

  def help_create
    puts 'Выберите желаемое действие. Некоторые функции станут доступны после создания обьектов!'
    puts 'Введите 1 => для создания поезда;'
    puts 'Введите 2 => для создания станции;'
    puts 'Введите 3 => для создания маршрута;' unless @stations.size < 2
    puts
    puts 'Для возврата в предыдущее меню нажмите Enter или 0 ...'
  end


  def change_object
    clear_screen  #system 'clear'
    puts 'Изменяем обьекты'
    loop do
      
      help_edit
      
      case gets.chomp.to_i
      when 0
        break
      when 1  
        system 'clear'
        puts 'Управление станциями на маршруте...'
        puts  '-*-' * 15
        show_routes_list
        puts  '-*-' * 15
        puts 'Выберите маршрут для его корректировки...'  
        route = @routes[gets.chomp.to_i - 1]
        puts "Выбран маршрут: #{route}"

        puts "Введите:\n 1 => для добавления промежуточной станции\n 2 => для удаления промежуточной станции\n 0 => для выхода из меню"
        selects = gets.chomp.to_i
        return if selects == 0
        if selects == 1
          puts 'Добавление промежуточной станции.'
          stations_to_add = @stations - route.stations
            if stations_to_add.any?
              puts stations_to_add
              puts 'Введите назавние новой промежуточной станции ...'
              intermediate_station = gets.chomp.capitalize
              route.add_intermediate_station(intermediate_station)
              puts "Сейчас выбранный маршрут содержит #{route.stations.size} cтанции(й): #{route.stations.join(' - ')}" # маршрут #{route} 
            else
              puts 'Ошибка, нет станций, которые можно было бы добавить в маршрут.'
            end
        elsif selects == 2 
          puts 'Удаление промежуточной станции'
          stations_to_remove = route.stations[1...-1]
          if stations_to_remove.any?
            puts stations_to_remove
            remove_station = gets.chomp.capitalize
            route.remove_intermediate_station(remove_station)
            puts "Станция #{remove_station} удалена из маршрута."
            puts "Сейчас выбранный маршрут содержит #{route.stations.size} cтанции(й): #{route.stations.join(' - ')}"
          else
            puts 'Ошибка, в маршруте нет промежуточных станций.'
          end
        else
          puts 'Неизвестная команда!'
        end
        sleep(0.3)
      when 2  
        system 'clear'
        puts  '-*-' * 15
        show_trains_list_number
        puts  '-*-' * 15
        puts 'Выберите поезд для управления его составом...'  
        train = @trains[gets.chomp.to_i - 1]
        puts "Выбран - #{train}"

        puts "Введите:\n 1 => для добавления вагона в состав\n 2 => для удаления вагона из состава\n 0 => для выхода из меню"
        sel = gets.chomp.to_i
        return if sel == 0
        if sel == 1
          puts ' Введеите 1 для добавления товарного (cargo) и 2 - для добавления пассажирского (passenger) вагонов'
          wagon_type = gets.chomp.to_i
          if wagon_type == 1 
            train.attach_wagon(CargoWagon.new)
            # train.attache_wagon(:cargo) 
          elsif wagon_type == 2 
            train.attach_wagon(PassengerWagon.new)
          else
            puts "Вагон другого типа и не добавлен в состав."
          end
        end
        if sel == 2
          train.detach_wagon
        end
        sleep(0.3)
      when 3  
        system 'clear'
        puts 'Назначаем маршрут поезду...'
        if @trains.empty? || @routes.empty?
          puts "Нужно сначала создать поезд/маршрут"
        else
          puts  '-*-' * 15
          show_trains_list_number
          puts  '-*-' * 15
          puts 'Выберите поезд для назначения маршрута...'  
          train = @trains[gets.chomp.to_i - 1]
          puts "Выбран - #{train}"
          puts  
          show_routes_list
          puts 'Введите номер маршрута для его назначения.'
          route = @routes[gets.chomp.to_i - 1]
          train.assign_a_route(route)
          puts 'Маршрут успешно назначен'
        end
        sleep(0.3)
      when 4  
        system 'clear'
        puts 'Перемещение поезда по маршруту...'
        puts 'Доступны следующие поезда:'
        show_trains_list_number
        puts 'Введите номер поезда для отправления: '
        train = @trains[gets.chomp.to_i - 1]
        if train
          loop do
            puts "Поезд находится на станции: #{train.current_station}"
            puts 'Введите 1 для отправления поезда вперед'
            puts 'Введите 2 для отправления поезда назад'
            puts
            puts 'Для возврата в предыдущее меню нажмите Enter или 0 ...'
            opt = gets.chomp.to_i
            case opt
            when 0
              break
            when 1
              if train.on_last_station?
                puts 'Ошибка, поезд на последней станции маршрута.'
              else
                train.go_to_next_station
                puts "Поезд прибыл на станцию #{train.current_station}"
              end
            when 2
              if train.on_first_station?
                puts 'Ошибка, поезд на первой станции маршрута.'
              else
                train.go_to_previous_station
                puts "Поезд прибыл на станцию #{train.current_station}"
              end
            else
              puts 'Неизвестная команда!'
            end
          end
        end
      else
        puts 'Неизвестная команда!'
      end
      sleep(0.3)
    end
  end

  def help_edit
    puts 'Выберите желаемое действие. Некоторые функции станут доступны после создания обьектов!'
    puts 'Введите 1 => для управления станциями;' unless @stations.size < 2
    puts 'Введите 2 => для управления составом;'  unless @trains.empty?
    puts 'Введите 3 => для назначения маршрута поезду;' unless @trains.empty? || @routes.empty?
    puts 'Введите 4 => для перемещения поезда по маршруту' unless @trains.empty? || @routes.empty?
    puts
    puts 'Для возврата в предыдущее меню нажмите Enter или 0 ...'
    
  end

  def info_object
    system 'clear'
    loop do

      help_info

      case gets.chomp.to_i
      when 0
        break
      when 1 
        clear_screen 
        puts "Информация о поездах"
        show_trains_list
        puts '-*-' * 20
        puts "Информация о станциях"
        show_stations_list
        puts '-*-' * 20
        puts "Информация о маршрутах"
        show_routes_list
        puts '-*-' * 20
      when 2
        puts  'Информация о поездах на станциях '
        show_station_info
        puts '-*-' * 20
      else
        puts 'Неизвестная команда!'
      end
      sleep(0.3)
    end
  end
  
  def help_info
    puts 'Выберите желаемое действие. Некоторые функции станут доступны после создания обьектов!'
    puts 'Введите 1 => для вывода информации о поездах, станциях и маршрутах;'
    puts 'Введите 2 => для вывода информации о поездах на станции;' unless @stations.size < 2
    puts
    puts 'Для возврата в предыдущее меню нажмите Enter или 0 ...'
  end
end


menu = Main.new
menu.start