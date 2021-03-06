class CargoTrain < Train
  attr_reader :type, :wagons

  def initialize(number, wagons)
    @type = :cargo
    super
  end

  def to_s
    'Грузовой ' + super
  end

  def attach_wagon(wagon)
    @wagons << wagon if wagon.is_a? CargoWagon
  end
end
