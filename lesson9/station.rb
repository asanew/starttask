# Станция
require_relative 'accessors'

class Station
  include Accessors

  attr_accessor_with_history :name

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  def self.all
    @@stations
  end

  def each_train
    if block_given?
      @trains.each { |train| yield train }
    else
      @trains.each
    end
  end

  def trains(type = nil)
    type ? @trains.select { |train| train.type == type } : @trains
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  @@stations = []
end
