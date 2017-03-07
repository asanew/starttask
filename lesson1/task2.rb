# Площадь треугольника

print "Введите длину высоты треугольника: "
triangle_height = gets.chomp.to_f

print "Введите длину основания треугольника: "
triangle_base = gets.chomp.to_f

triangle_square = 1.0/2*triangle_height*triangle_base

puts "Площадь треугольника равна: #{triangle_square}"

