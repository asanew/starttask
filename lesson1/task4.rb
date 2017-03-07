# Вычисление корней квадратного уравнения

print "Введите коэффициент a: "
a = gets.chomp.to_f

print "Введите коэффициент b: "
b = gets.chomp.to_f

print "Введите коэффициент c: "
c = gets.chomp.to_f

d = (b**2 - 4*a*c)


if d>0
	sqrt_from_d = Math.sqrt(d)
	x1 = (-b + sqrt_from_d)/(2*a)
	x2 = (-b - sqrt_from_d)/(2*a)
	puts "Уравнение имеет два корня"
	puts "x1 = #{x1}, x2 = #{x2}"
elsif
	x1 = (-b)/(2*a)
	puts "Уравнение имеет один корень"
	puts "x = #{x1}"
else
	puts "Уравнение корней не имеет"
end

