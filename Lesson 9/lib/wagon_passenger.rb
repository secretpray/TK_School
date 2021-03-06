# frozen_string_literal: true

class PassengerWagon < Wagon
  include InstanceCounter
  include Validation
  extend Accessors

  TYPE_WAGON_ERROR = '-> неверный тип вагона'
  SIZE_ERROR_DATE  = '-> вместимость выражается в числах'
  SIZE_ERROR       = '-> неверно указана вместимость вагона'
  NAME_WAGON       = 'Пассажирский вагон' # тип "#{self.class}"
  TYPE             = :passenger
  MIN_SIZE         = 18
  MAX_SIZE         = 64

  # attr_reader :type_wagon, :number, :place_count, :places_filled
  attr_accessor_with_history :type_wagon, :number, :place_count, :places_filled

  alias size place_count
  alias filled_size places_filled

  validate  :place_count, :presence
  validate  :place_count, :positive
  validate  :type_wagon,  :presence

  def initialize(size)
    @type_wagon     = TYPE
    @place_count    = size
    @places_filled  = 0
    validate!
    @number = rand(1..40)
    super
  end

  def fill
    can_fill? ? self.places_filled += 1 : (raise 'Вагон заполнен')
  end

  def clear
    can_clear? ? self.places_filled -= 1 : (raise 'Вагон пуст')
  end

  def free_size
    place_count - places_filled
  end

  def to_s
    NAME_WAGON + " номер #{number}, всего мест: #{place_count}, " \
    "свободно мест: #{free_size}."
  end

  def name
    NAME_WAGON + " номер #{number}, всего мест: #{place_count}, " \
    "свободно мест: #{free_size}."
  end

  protected

  attr_writer :places_filled

  def can_fill?
    free_size.positive? # free_places > 0
  end

  def can_clear?
    places_filled >= 1
  end
end
