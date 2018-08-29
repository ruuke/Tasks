puts "Программа определяет является ли треугольник прямоугольным по трем его сторонам."
sleep 1
puts "Введите сторону (a) треугольника"
a = gets.chomp.to_f
puts "Введите сторону (b) треугольника"
b = gets.chomp.to_f
puts "Введите сторону (c) треугольника"
c = gets.chomp.to_f
sides = [a, b, c].sort
	if sides[2]**2 == sides[0]**2+sides[1]**2
		puts "Треугольник прямоугольный"
	elsif a == b && b == c
		puts 'Треугольник равносторонний'
	elsif a == b or a == c or b == c
		puts "Треугольник равнобедренный"
	else
		puts 'Треугольник не прямоугольный'
	end