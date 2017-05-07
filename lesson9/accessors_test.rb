require_relative 'accessors'

class AccessorsTest
  include Accessors

  attr_accessor_with_history :h_test
  
  strong_attr_accessor :strong_test, Fixnum
end

test_obj = AccessorsTest.new

puts test_obj.h_test = 5677
puts test_obj.h_test = 'rsrrew'
puts test_obj.h_test = 2234
puts "Values history:"
puts test_obj.h_test_history
puts
puts test_obj.strong_test = 15
#puts test_obj.strong_test = "ewrwr"

