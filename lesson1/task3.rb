# Какой треугольник

print "Введите первую сторону треугольника: "
side1 = gets.chomp.to_f

print "Введите вторую сторону треугольника: "
side2 = gets.chomp.to_f

print "Введите третью сторону треугольника: "
side3 = gets.chomp.to_f

if side1==side2 && side2==side3
	puts "Треугольник равносторонний"
elsif side1 == side2 || side2==side3 || side1==side3
	puts "Треугольник равнобедренный"
else 
	puts "Треугольник не является равнобедренным"
end

hypo = 0
katet1 = 0
katet2 = 0

if side1 > side2 && side1 > side3
	hypo = side1
	katet1 = side2
	katet2 = side3
elsif side2 > side1 && side2 > side3
	hypo = side2
	katet1 = side1
	katet2 = side3
elsif side3 > side1 && side3 > side2
	hypo = side3
	katet1 = side1
	katet2 = side2
end

if hypo != 0 && hypo**2 == (katet1**2 + katet2**2)
	puts "Треугольник прямоугольный"
else
	puts "Треугольник не прямоугольный"
end

