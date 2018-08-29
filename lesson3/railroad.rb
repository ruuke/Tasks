class RailRoad
  attr_reader :stations, :routes, :trains_in_railroad, :wagons
  def initialize    
    @routes = []
    @trains_in_railroad = []
    @wagons = []
    @stations = []
  end

  def seed
    @st1 = Station.new("Ufa")
    @st2 = Station.new("Msk")
    @st3 = Station.new("Spb")
    @st4 = Station.new("Ekb")
    @stations << @st1
    @stations << @st2
    @stations << @st3
    @stations << @st4
    @r1 = Route.new(@st1, @st2)
    @r2 = Route.new(@st3, @st4)
    @r1.add_station(@st3)
    @r2.add_station(@st2)
    @routes << @r1
    @routes << @r2
    @tr1 = CargoTrain.new(111)
    @tr2 = PassengerTrain.new(222)
    @trains_in_railroad << @tr1
    @trains_in_railroad << @tr2
  end

  # Stations menu

  def stations_menu
    loop do
      puts "Выберите пункт меню"
      puts "1. Создать станцию"
      puts "2. Выбрать станцию."
      puts "3. Вывести список станций."
      puts "0. Выйти из меню."
      select_input = gets.chomp
      break if select_input == "0"
      case select_input
      when "1"
        new_station
      when "2"
        select_station
      when "3"
        show_stations
      else
        puts "Выберите значение из списка"
        stations_menu
      end

    end
  end

  def new_station
    puts "Введите название станции"
    station_name = gets.capitalize.chomp
    @stations.each do |station| 
      if station.name == station_name
        puts "Данная станция уже существует." 
        new_station
      end
    end
      @stations << Station.new(station_name)
      puts "Станция #{station_name} создана"
  end

  def show_stations
    if @stations.length.zero?
      puts "Список станций пуст. Создайте станции."
      new_station
    end
    index = 1
    @stations.each do |station| 
      puts "#{index}. #{station.name}"
      index +=1
    end
  end

  def select_station
    puts "Выберите станцию из списка и введите ее номер" unless @stations.length.zero?
    show_stations
    selected_station = gets.chomp.to_i
    if selected_station < 1 || selected_station > @stations.length
      return select_station
    end
      @stations[selected_station - 1].trains
  end

  def show_train_in_station
    index = 1
    @stations.each do |station|
      puts "#{index}. #{station.name} - #{station.trains}"
      index += 1
    end
  end

  # Trains menu

  def new_train
    puts "Выберите тип поезда:"
    puts "1. Пассажирский поезд"
    puts "2. Грузовой поезд"
    train_type = gets.chomp
    case train_type
    when "1" 
      new_passenger_train
    when "2"
      new_cargo_train
    else
      puts "Выберите предложенные варианты"
      new_train
    end
  end


  def new_passenger_train
    puts "Введите номер поезда"
    train_number = gets.chomp.to_i
    @trains_in_railroad.each do |train|
      if train.number == train_number
        puts "Данный поезд уже существует"
        new_passenger_train
      end
    end
    @trains_in_railroad << PassengerTrain.new(train_number)
    puts "Поезд номер #{train_number} создан"
  end

  def new_cargo_train
    puts "Введите номер поезда"
    train_number = gets.chomp
    @trains_in_railroad.each do |train|
      if train.number == train_number
        puts "Данный поезд уже существует"
        new_cargo_train
      end
    end
    @trains_in_railroad << CargoTrain.new(train_number)
    puts "Поезд номер #{train_number} создан"
  end

  def show_trains
    if @trains_in_railroad.length.zero?
      puts "Список поездов пуст. Создайте поезда."
      new_train
    end
    index = 1
    @trains_in_railroad.each do |train|
      puts "#{index}. Поезд № #{train.number}, тип #{train.type}"
      index += 1
    end
  end

  def select_train
    puts "Выберите поезд" unless @trains_in_railroad.length.zero?
    show_trains
    selected_train = gets.chomp.to_i
    if selected_train < 1 || selected_train > @trains_in_railroad.length
      puts "Выберите значение из списка"
      return select_train
    end
    @trains_in_railroad[selected_train - 1]
  end

  def add_train_to_route
    selected_train = select_train
    selected_route = select_route
    selected_train.take_route(selected_route)
  end

  def train_drive_forward
    selected_train = select_train
    selected_train.drive_forward
  end 

  def train_drive_back
    selected_train = select_train
    selected_train.drive_back
  end

  def add_wagon_to_train
    selected_train = select_train
    selected_wagon = select_wagon
    selected_train.add_wagon(selected_wagon)
  end

  def show_train_wagons
    index = 1
    @selected_train = select_train
    @selected_train.train_wagons.each do |wagon|
      puts "#{index}. #{wagon}"
      index += 1
    end    
  end

  def remove_wagon_from_train
    show_train_wagons
    deleted_wagon = gets.chomp.to_i
    @selected_train.train_wagons.remove_wagon
  end





  # Wagons menu

  def new_wagon
    puts "Выберите тип вагона:"
    puts "1.Пассажирский."
    puts "2.Грузовой."
    selected_wagon_type = gets.chomp.to_i
    if selected_wagon_type == 1
      @wagons << PassengerWagon.new
    elsif selected_wagon_type == 2
      @wagons << CargoWagon.new
    else
      puts "Выберите предложенные варианты"
      return new_wagon
    end
  end

  def show_wagons
    index = 1
    @wagons.each do |wagon|
      puts "#{index}. #{wagon}"
      index += 1
    end
  end

  def select_wagon
    puts "Выберите вагон соответсвующий типу поезда"
    show_wagons
    selected_wagon = gets.chomp.to_i
    if selected_wagon < 1 || selected_wagon > @wagons.length
      puts "Выберите из предложенных вариантов"
    end
    @wagons[selected_wagon - 1]
  end






  # Routes menu

  def new_route
    if @stations.length >= 2
      puts "first"
      show_stations
      selected_first_station = gets.chomp.to_i
      first_station = @stations[selected_first_station - 1]
      puts "second"
      show_stations
      selected_second_station = gets.chomp.to_i
      if selected_second_station == selected_first_station
        puts "Выберите станцию отличную от первой."
        return new_route
      else
        second_station = @stations[selected_second_station - 1]
        @routes << Route.new(first_station, second_station)
      end
    else
      puts "Создайте станцию"
      new_station
    end
  end

  def show_routes
    index = 1
    @routes.each do |current_route|
      puts "#{index}. #{current_route.route_stations.first.name} - #{current_route.route_stations.last.name}"
      index += 1
    end
  end

  def show_stations_in_route
    select_route.route_stations.each_with_index{|station, i| puts "#{i + 1} #{station.name}"}
  end

  def select_route
    puts "Выберите маршрут"
    show_routes
    @selected_route = gets.chomp.to_i
    if @selected_route <1 || @selected_route > @routes.length
      puts "Выберите из предложенных вариантов"
      return select_route
    end
    @routes[@selected_route - 1]
  end

  def add_station_to_route
    selected_station = select_station
    select_route.add_station(selected_station)

  end

  def delete_station_from_route
    puts "Выберите маршрут, чтобы посмотреть список станций и укажите станцию для удаления."
    selected_station = select_station
    select_route.remove_station(selected_station)
  end

  

    









end
