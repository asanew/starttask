require_relative 'validation'
require_relative 'accessors'

class ValidationTest
  include Accessors
  include Validation

  attr_accessor_with_history :h_test

  validate :h_test, :presence
  validate :h_test, :format, /^[0-9]{0,4}$/
  validate :h_test, :type, String

end

test_obj = ValidationTest.new
test_obj.h_test = nil
puts test_obj.valid?
test_obj.h_test = "145"
puts test_obj.h_test
puts test_obj.valid?

