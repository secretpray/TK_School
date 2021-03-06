require_relative "instance_counter"
require_relative "manufacture"
require_relative 'validate'
require_relative "interface"
require_relative "station"
require_relative "route"
require_relative "train"
require_relative "train_passenger"
require_relative "train_cargo"
require_relative "wagon"
require_relative "wagon_passenger"
require_relative "wagon_cargo"
# require_relative "main"
require 'io/console' # (для использования STDIN.getch вместо gets)


cargo_pass1 = []
cargo_pass2 = [] 
cargo_pass3 = []

rand(7..30).times { cargo_pass1 << CargoWagon.new(rand(60...120)) }
rand(7..30).times { cargo_pass2 << CargoWagon.new(rand(60...120)) }
rand(7..30).times { cargo_pass3 << CargoWagon.new(rand(60...120)) }

@cargo1 = CargoTrain.new((rand(100...999).to_s + "-" + rand(10...99).to_s), cargo_pass1)
@cargo2 = CargoTrain.new((rand(100...999).to_s + "-" + rand(10...99).to_s), cargo_pass2)
@cargo3 = CargoTrain.new((rand(100...999).to_s + "-" + rand(10...99).to_s), cargo_pass3)

wagon_pass1 = [] 
wagon_pass2 = [] 
wagon_pass3 = []

rand(7..30).times { wagon_pass1 << PassengerWagon.new(rand(18...64)) }
rand(7..30).times { wagon_pass2 << PassengerWagon.new(rand(18...64)) }
rand(7..30).times { wagon_pass3 << PassengerWagon.new(rand(18...64)) }

@passenger1 = PassengerTrain.new((rand(100...999).to_s + "-" + rand(10...99).to_s), wagon_pass1)
@passenger2 = PassengerTrain.new((rand(100...999).to_s + "-" + rand(10...99).to_s), wagon_pass2)
@passenger3 = PassengerTrain.new((rand(100...999).to_s + "-" + rand(10...99).to_s), wagon_pass3)


@station1 = Station.new("Киев")
@station2 = Station.new("Минск")
@station3 = Station.new("Москва")
@station4 = Station.new("Питер")

@route1 = Route.new(@station1, @station2)
@route2 = Route.new(@station2, @station3)


@cargo1.assign_a_route(@route2)
@passenger1.assign_a_route(@route1)

wagonpass1 = PassengerWagon.new(27)
wagonpass2 = PassengerWagon.new(42)

@passenger1.attach_wagon(wagonpass1)
@passenger1.attach_wagon(wagonpass2)

@passenger1.each_wagons do |wagon| 
  puts "Номер вагона: #{wagon.number}, тип вагона: #{wagon.type_wagon}"
  puts "кол-во свободных мест: #{wagon.free_places}, количество занятых мест:#{wagon.filled_size}"
end

p '=' * 50

@station1.each_train do |train|
  puts "Номер поезда: #{train.number}, тип поезда: #{train.type}"
  puts "Количество вагонов: #{train.wagons.size}"
end
