# Вагоны

require_relative 'manufacter'

class Wagon
  attr_reader :type
  include Manufacter
end
