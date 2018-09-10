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
    @tr1 = CargoTrain.new("111-11")
    @tr2 = PassengerTrain.new('222-22')
    @trains_in_railroad << @tr1
    @trains_in_railroad << @tr2
    @wagons << CargoWagon.new(100)
    @wagons << PassengerWagon.new(20)
    @wagons << CargoWagon.new(200)
    @wagons << PassengerWagon.new(40)
  end

  # Main menu

  def main_menu
    loop do
      puts "Выберите пункт меню"
      puts "1. Меню станций."
      puts "2. Меню поездов."
      puts "3. Меню маршрутов."
      puts "4. Меню вагонов."
      puts "0. Выйти из программы."
      select_input = gets.chomp
      break if select_input == "0"
      case select_input
      when "1"
        stations_menu
      when "2"
        trains_menu
      when "3"
        routes_menu
      when "4"
        wagons_menu
      else
        puts "Выберите значение из списка"
        main_menu
      end
    end
  end

  # Stations menu

  def stations_menu
    loop do
      puts "Выберите пункт меню"
      puts "1. Создать станцию"
      puts "2. Вывести список станций."
      puts "3. Вывести список поездов на станции."
      puts "0. Выйти из меню."
      select_input = gets.chomp
      break if select_input == "0"
      case select_input
      when "1"
        new_station
      when "2"
        show_stations
      when "3"
        show_trains_in_stations
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
        return new_station
      end
    end
    begin
      @stations << Station.new(station_name)
      puts "Станция #{station_name} создана"
    rescue RuntimeError => e
      puts e.inspect
    end
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
      @stations[selected_station - 1]
  end

  def show_trains_in_stations
    # index = 1
    # @stations.each do |station|
    #   puts "#{index}. #{station.name} - #{station.trains}"
    #   index += 1
    selected_station = select_station
    if selected_station.trains.length == 0
      puts "На станции нет поездов"
    else
      Station.do_smthng_with_stations(selected_station) do |train|
        puts "№ #{train.number}, тип - #{train.type}, кол-во вагонов - #{train.train_wagons.length}"
      end
    end
  end

  # Trains menu

  def trains_menu
    loop do
      puts "Выберите пункт меню"
      puts "1. Создать поезд"
      puts "2. Показать список поездов."
      puts "3. Добавить маршрут поезду."
      puts "4. Прицепить вагон поезды."
      puts "5. Отцепить вагон от поезда."
      puts "6. Отправить поезд на следующую станцию."
      puts "7. Отправить поезд на предыдущую станцию."
      puts "8. Показать прицепленные к поезду вагоны."
      puts "0. Выйти из меню."
      select_input = gets.chomp
      break if select_input == "0"
      case select_input
      when "1"
        new_train
      when "2"
        show_trains
      when "3"
        add_train_to_route
      when "4"
        add_wagon_to_train
      when "5"
        remove_wagon_from_train
      when "6"
        train_drive_forward
      when "7"
        train_drive_back
      when "8"
        show_train_wagons
      else
        puts "Выберите значение из списка"
        trains_menu
      end
    end
  end

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
    puts "Введите номер поезда в формате три цифры/буквы, необязательный пробел, две цифры/буквы."
    train_number = gets.chomp.to_s
    @trains_in_railroad.each do |train|
      if train.number == train_number
        puts "Данный поезд уже существует"
        return new_passenger_train
      end
    end
    begin
      @trains_in_railroad << PassengerTrain.new(train_number)
      puts "Поезд номер #{train_number} создан"
    rescue RuntimeError => e
      puts e.inspect
      return new_passenger_train
    end
  end

  def new_cargo_train
    puts "Введите номер поезда в формате три цифры/буквы, необязательный пробел, две цифры/буквы."
    train_number = gets.chomp.to_s
    @trains_in_railroad.each do |train|
      if train.number == train_number
        puts "Данный поезд уже существует"
        return new_cargo_train
      end
    end
    begin
      @trains_in_railroad << CargoTrain.new(train_number)
      puts "Поезд номер #{train_number} создан"
    rescue RuntimeError =>  e
      puts e.inspect
      return new_cargo_train
    end
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
    puts "Поезд помещен на станцию #{selected_route.route_stations.first.name}"
  end

  def train_drive_forward
    selected_train = select_train
    if selected_train.next_station == nil
      puts "Станция #{selected_train.current_station.name} конечная."
      return trains_menu
    end
    selected_train.drive_forward
    puts "Поезд помещен на станцию #{selected_train.current_station.name}."
  end 

  def train_drive_back
    selected_train = select_train
    if selected_train.previous_station == nil
      puts "Станция #{selected_train.current_station.name} начальная."
      return trains_menu
    end
    selected_train.drive_back
    puts "Поезд помещен на станцию #{selected_train.current_station.name}."
  end

  def add_wagon_to_train
    selected_train = select_train
    selected_wagon = select_wagon
    if selected_wagon == nil
      puts "Данного вагона не сущесвует"
    elsif selected_wagon.type != selected_train.type
      puts "Неверно выбран тип вагона"
    elsif selected_train.train_wagons.include?(selected_wagon)
      puts "Данный вагон уже прицеплен"
    elsif selected_train.speed == 0 && selected_wagon.type == selected_train.type 
      selected_train.add_wagon(selected_wagon)
      puts "Вагон прицеплен."
    end
  end

  def show_train_wagons
    # index = 1
    # @selected_train = select_train
    # if @selected_train.train_wagons.length.zero?
    #   puts "К поезду не прицеплены вагоны."
    # else
    #   @selected_train.train_wagons.each do |wagon|
    #     puts "#{index}. #{wagon}"
    #     index += 1
    #   end
    index = 1
    @selected_train = select_train
    if @selected_train.train_wagons.length.zero?
      puts "К поезду не прицеплены вагоны."
    elsif @selected_train.type == :cargo
      Train.do_smthng_with_train_wagons(@selected_train.number) do |wagon|
        puts "#{index}. тип - #{wagon.type}, свободный объем - #{wagon.free_volume}, занятый объем - #{wagon.taken_volume}"
        index += 1
      end
    elsif @selected_train.type == :passenger
      Train.do_smthng_with_train_wagons(@selected_train.number) do |wagon|
        puts "#{index}. тип - #{wagon.type}, свободных мест - #{wagon.free_seats}, занятых мест- #{wagon.taken_seats}"
        index +=1
      end
    end    
  end

  def remove_wagon_from_train
    show_train_wagons
    deleted_wagon = select_wagon
    if !@selected_train.train_wagons.include?(deleted_wagon)
      puts "Такой вагон не приценлен к поезду."
    elsif @selected_train.speed == 0 && @selected_train.train_wagons.include?(deleted_wagon)
      @selected_train.remove_wagon(deleted_wagon)
      puts "Вагон отцеплен."
    end
  end

  # Wagons menu

  def wagons_menu
    loop do
      puts "Выберите пункт меню"
      puts "1. Создать вагон"
      puts "2. Показать список вагонов."
      puts "3. Занять место/объем в вагоне."
      puts "0. Выйти из меню."
      select_input = gets.chomp
      break if select_input == "0"
      case select_input
      when "1"
        new_wagon
      when "2"
        show_wagons  
      when "3"
        wagons_manipulations
      else
        puts "Выберите значение из списка"
        wagons_menu
      end
    end
  end

  def new_wagon
    puts "Выберите тип вагона:"
    puts "1.Пассажирский."
    puts "2.Грузовой."
    selected_wagon_type = gets.chomp.to_i
    if selected_wagon_type == 1
      puts "Введите количесво пассажирских мест."
      total_seats = gets.chomp.to_i
      @wagons << PassengerWagon.new(total_seats)
      puts "Вагон создан"
    elsif selected_wagon_type == 2
      puts "Введите объем вагона."
      total_volume = gets.chomp.to_i 
      @wagons << CargoWagon.new(total_volume)
      puts "Вагон создан"
    else
      puts "Выберите предложенные варианты"
      return new_wagon
    end
  end

  def show_wagons
    index = 1
    if @wagons.length.zero?
      puts "Список пуст. Создайте вагон."
    else
      @wagons.each do |wagon|
        puts "#{index}. #{wagon}"
        index += 1
      end
    end
  end

  def select_wagon
    puts "Выберите вагон."
    show_wagons
    selected_wagon = gets.chomp.to_i
    if selected_wagon < 1 || selected_wagon > @wagons.length
      puts "Выберите из предложенных вариантов"
    end
    @wagons[selected_wagon - 1]
  end

  def wagons_manipulations
    begin
      @selected_wagon = select_wagon
      case @selected_wagon.type
      when :cargo
        take_volume
      when :passenger
        take_a_seat
      end
    rescue Exception => e 
      puts e.inspect
      puts "Выберите значение из списка вагонов"
      return wagons_menu
    end
  end

  def take_volume
    puts "Введите занимаемый объем."
    taken_volume = gets.chomp.to_i
    @selected_wagon.take_volume(taken_volume)
    puts "Занято - #{@selected_wagon.taken_volume}, свободно - #{@selected_wagon.free_volume}"
  end

  def take_a_seat
    @selected_wagon.take_a_seat
    puts "Занято мест - #{@selected_wagon.taken_seats}, свободно мест - #{@selected_wagon.free_seats}"
  end


  # Routes menu

  def routes_menu
    loop do
      puts "Выберите пункт меню"
      puts "1. Создать маршрут"
      puts "2. Показать список маршрутов."
      puts "3. Добавить станцию в маршрут."
      puts "4. Удалить станцию из маршрута."
      puts "5. Показать станции в маршруте."
      puts "0. Выйти из меню."
      select_input = gets.chomp
      break if select_input == "0"
      case select_input
      when "1"
        new_route
      when "2"
        show_routes
      when "3"
        add_station_to_route
      when "4"
        delete_station_from_route
      when "5"
        show_stations_in_route
      else
        puts "Выберите значение из списка"
        return routes_menu
      end
    end
  end

  def new_route
    if @stations.length >= 2
      puts "Выберите первую станцию маршрута."
      show_stations
      selected_first_station = gets.chomp.to_i
      first_station = @stations[selected_first_station - 1]
      puts "Выберите последнюю станцию маршрута."
      show_stations
      selected_second_station = gets.chomp.to_i
      if selected_second_station == selected_first_station
        puts "Выберите станцию отличную от первой."
        return new_route
      else
        begin
          second_station = @stations[selected_second_station - 1]
          @routes << Route.new(first_station, second_station)
          puts "Маршрут создан."
        rescue RuntimeError => e
          puts e.inspect
          return routes_menu
        end
      end
    else
      puts "Создайте станцию"
      new_station
    end
  end

  def show_routes
    index = 1
    if @routes.length.zero?
      puts "Список станций пуст."
    else
      @routes.each do |current_route|
        puts "#{index}. #{current_route.route_stations.first.name} - #{current_route.route_stations.last.name}"
        index += 1
      end
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
    selected_route = select_route
    if selected_route.route_stations.include?(selected_station)
      puts "Станция #{selected_station.name} есть в списке маршрута."
      return routes_menu
    end
    begin
      select_route.add_station(selected_station)
      puts "Станция #{selected_station.name} добавлена в маршрут."
    rescue RuntimeError => e 
      puts e.inspect
      return routes_menu
    end
  end

  def delete_station_from_route
    selected_station = select_station
    selected_route = select_route
    if [selected_route.route_stations.first, selected_route.route_stations.last].include?(selected_station)
      puts "Начальную и конечную станцию маршрута нельзя удалить."
    elsif !selected_route.route_stations.include?(selected_station)
      puts "Данной станции нет в списке маршрута."
    else
      begin
        selected_route.remove_station(selected_station)
        puts "Станция #{selected_station.name} удалена из маршрута."
      rescue RuntimeError => e 
        puts e.inspect
        return routes_menu
      end
    end
  end
end
