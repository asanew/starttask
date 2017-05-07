# Производитель
require_relative 'accessors'

module Manufacter
  include Accessors
  strong_attr_accessor :manufacter_name, String
end
